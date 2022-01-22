import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/dataModels/login_response.dart';
import 'package:detoxa/services/navigation/navigation_service.dart';
import 'package:detoxa/services/network/config.dart';
import 'package:detoxa/services/network/urls.dart';
import 'package:detoxa/services/storage/device_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class AuthService with ReactiveServiceMixin {
  // final int otpLength = 4;
  NetworkService _networkService;
  DeviceStorage _storageService;

  AuthService() {
    _networkService = locator<NetworkService>();
    _storageService = locator<DeviceStorage>();
    // listenToReactiveValues([]);
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

  Future<bool> loginWithOtp(String mobile, String otp) async {
    try {
      var response = await _networkService.postMethod(
        NetworkUrls.loginWithoutPassword,
        data: {
          "phone": mobile,
          "login_otp": otp,
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

  Future<bool> generateOtp(String mobile) async {
    try {
      var response = await _networkService.postMethod(
        NetworkUrls.generateSignInOtp,
        data: {"mobile_no": mobile},
      );
      if (response.statusCode >= 300) throw response;
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> registerUser({
    @required String email,
    @required String phone,
    @required String name,
    @required String password,
    @required bool termsAccepted,
  }) async {
    try {
      var response = await _networkService.postMethod(
        NetworkUrls.register,
        data: {
          "mobile": "91$phone",
          "email": email,
          "password": password,
          "full_name": name,
          "is_tnc_accepted": termsAccepted,
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
      var response = await _networkService.postMethod(
        NetworkUrls.signout,
      );
      if (response.statusCode >= 300) throw response;
      locator<DeviceStorage>().clearData();
      locator<NavigationService>().pop();
    } catch (e) {
      rethrow;
    }
  }
}
