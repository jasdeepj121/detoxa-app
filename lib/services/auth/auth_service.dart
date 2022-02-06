import 'dart:io';

import 'package:detoxa/app/appRouter/router.dart';
import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/dataModels/gender.dart';
import 'package:detoxa/dataModels/login_response.dart';
import 'package:detoxa/dataModels/otp.dart';
import 'package:detoxa/dataModels/user.dart';
import 'package:detoxa/dataModels/user_subscription.dart';
import 'package:detoxa/services/navigation/navigation_service.dart';
import 'package:detoxa/services/network/config.dart';
import 'package:detoxa/services/network/urls.dart';
import 'package:detoxa/services/storage/device_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:detoxa/dataModels/child.dart';

@lazySingleton
class AuthService with ReactiveServiceMixin {
  final int otpLength = 6;
  NetworkService _networkService;
  DeviceStorage _storageService;
  ReactiveValue<User> user = ReactiveValue(User());
  ReactiveValue<UserSubscription> userSubscription =
      ReactiveValue(UserSubscription());
  List<Child> childList = [];

  AuthService() {
    _networkService = locator<NetworkService>();
    _storageService = locator<DeviceStorage>();
    listenToReactiveValues([
      user,
      userSubscription,
    ]);
  }

  void extractUserDetails(Map<String, dynamic> json) {
    try {
      if (json == null) return;
      user.value = User.fromJson(json);
      //update user in storage
    } catch (_) {}
  }

  void extractSubsciptionDetails(Map<String, dynamic> json) {
    try {
      if (json == null) return;
      userSubscription.value = UserSubscription.fromJson(json);
      //update subscription in storage
    } catch (_) {}
  }

  Future<bool> loginWithPassword(String email, String password) async {
    try {
      var response = await _networkService.postMethod(
        NetworkUrls.loginWithPassword,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode >= 300) throw response;
      var responseData = LoginResponse.fromJson(response.data);
      await _storageService.setAccessToken(responseData.token);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> loginWithOtp({
    @required String mobile,
    @required Otp otpObject,
    @required String otp,
  }) async {
    try {
      var response = await _networkService.postMethod(
        NetworkUrls.loginWithoutPassword,
        data: {
          "mobile": "91$mobile",
          "session_id": otpObject.details,
          "otp": otp
        },
      );
      if (response.statusCode >= 300) throw response;
      var responseData = LoginResponse.fromJson(response.data);
      await _storageService.setAccessToken(responseData.token);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<Otp> generateOtp(String mobile) async {
    try {
      var response = await _networkService.postMethod(
        NetworkUrls.generateSignInOtp,
        data: {"mobile_no": "91$mobile"},
      );
      if (response.statusCode >= 300) throw response;
      Otp otp = Otp.fromJson(response.data["otp"]);
      return otp;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> registerUser(
      {@required String email,
      @required String phone,
      @required String name,
      @required String password,
      @required bool termsAccepted,
      @required String otp,
      @required String sessionId}) async {
    try {
      var response = await _networkService.postMethod(
        NetworkUrls.register,
        data: {
          "mobile": "91$phone",
          "email": email,
          "password": password,
          "full_name": name,
          "is_tnc_accepted": termsAccepted,
          "session_id": sessionId,
          "otp": otp,
        },
      );
      if (response.statusCode >= 300) throw response;
      return true;
    } catch (e) {
      rethrow;
    }
  }

  // Future<bool> forgotPassword(String email) async {
  //   try {
  //     var response = await _networkService.postMethod(
  //       NetworkUrls.forgotPassword,
  //       data: {
  //         "email": email,
  //       },
  //     );
  //     if (response.statusCode != 200) throw response;
  //     return true;
  //   } catch (e) {
  //     print(e.toString());
  //     rethrow;
  //   }
  // }

  // Future<User> getUserProfile() async {
  //   try {
  //     var response = await _networkService.getMethod(NetworkUrls.userProfile);
  //     if (response.statusCode != 200) throw response;
  //     user.value = User.fromJson(response.data["user"]);
  //     _storageService.setUserData(user.value);
  //     return user.value;
  //   } catch (e) {
  //     print(e.toString());
  //     if (_storageService.user != null) {
  //       user.value = _storageService.user;
  //       return user.value;
  //     }
  //     rethrow;
  //   }
  // }

  void logout() async {
    try {
      // var response = await _networkService.postMethod(
      //   NetworkUrls.signout,
      // );
      // if (response.statusCode >= 300) throw response;
      locator<DeviceStorage>().clearData();
      locator<NavigationService>()
          .pushNamedAndRemoveUntil(Routes.loginView, (p0) => false);
    } catch (e) {
      rethrow;
    }
  }

  Future getChildList() async {
    try {
      var response = await _networkService.getMethod(
        NetworkUrls.getChildList,
      );
      childList = List<Child>.from(
          (response.data["data"] as List).map((e) => Child.fromJson(e)));
      extractUserDetails(response.data["my_details"]);
      extractSubsciptionDetails(response.data["subscription_data"]);
    } catch (e) {
      print(e.toString());
    }
  }

  Future createChild({
    String name,
    DateTime dob,
    Gender gender,
    String age,
    String pictureUrl,
  }) async {
    try {
      var response =
          await _networkService.postMethod(NetworkUrls.createChild, data: {
        "full_name": name,
        "dob": dob.toIso8601String(),
        "gender": gender == Gender.male ? "Male" : "Female",
        "picture_url": pictureUrl,
        "age": age,
      });
      print(response.data.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteChild(String id) async {
    try {
      var response = await _networkService.deleteMethod(
        "${NetworkUrls.deleteChild}/$id",
      );
      print(response.data.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  Future getChildDetails(String id) async {
    try {
      var response = await _networkService.getMethod(
        "${NetworkUrls.getChildDetails}/$id",
      );
      print(response.data.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateChild(String id) async {
    try {
      var response = await _networkService.getMethod(
        "${NetworkUrls.updateChildDetails}/$id",
      );
      print(response.data.toString());
    } catch (e) {
      print(e.toString());
    }
  }
}
