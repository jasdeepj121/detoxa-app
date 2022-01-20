import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/services/navigation/navigation_service.dart';
import 'package:detoxa/services/network/config.dart';
import 'package:detoxa/services/network/urls.dart';
import 'package:detoxa/services/storage/device_storage_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class AuthService with ReactiveServiceMixin {
  final int otpLength = 4;
  NetworkService _networkService;
  DeviceStorage _storageService;

  AuthService() {
    _networkService = locator<NetworkService>();
    _storageService = locator<DeviceStorage>();
    listenToReactiveValues([]);
  }

  Future<bool> loginWithPassword(String mobile, String password) async {
    try {
      var response = await _networkService.postMethod(
        NetworkUrls.loginWithPassword,
        data: {
          "phone": mobile,
          "password": password,
        },
      );
      print("");
      // String token =
      //     (response.data["data"] as Map<String, dynamic>)["access_token"];
      // await _storageService.setAccessToken(token);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> loginWithOtp(String mobile, int otp) async {
    try {
      var response = await _networkService.postMethod(
        NetworkUrls.loginWithoutPassword,
        data: {
          "phone": mobile,
          "login_otp": otp,
        },
      );
      String token =
          (response.data["data"] as Map<String, dynamic>)["access_token"];
      await _storageService.setAccessToken(token);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> generateOtp(int mobile) async {
    try {
      var response = await _networkService.postMethod(
        NetworkUrls.generateSignInOtp,
        data: {"phone": mobile},
      );
      if (response.statusCode != 200) throw response;
      return true;
    } catch (e) {
      rethrow;
    }
  }

  // Future updateOtp(int mobile) async {
  //   try {
  //     var response = await _networkService.postMethod(
  //       NetworkUrls.updateOTP,
  //       data: {"phone": mobile},
  //     );
  //     if (response.statusCode != 200) throw response;
  //     return true;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<bool> userRegistrationValidation(RegisterUser details) async {
  //   try {
  //     var response = await _networkService.postMethod(
  //       NetworkUrls.userRegistrationFormValidation,
  //       data: details.toJson(),
  //     );
  //     if (response.statusCode != 200) throw response;
  //     if ((response.data["success"]) == false) throw response;
  //     return true;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<bool> userRegistration(RegisterUser details) async {
  //   try {
  //     var response = await _networkService.postMethod(
  //       NetworkUrls.userRegistration,
  //       data: details.toJson(),
  //     );
  //     if (response.statusCode != 200) throw response;
  //     return true;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<RegistrationFormData> fetchRegistrationFormData() async {
  //   try {
  //     var response = await _networkService.getMethod(
  //       NetworkUrls.userRegistrationFormData,
  //     );
  //     if (response.statusCode != 200) throw response;
  //     return RegistrationFormData.fromJson(response.data);
  //   } catch (e) {
  //     print(e.toString());
  //     rethrow;
  //   }
  // }

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

  void logout() {
    try {
      locator<DeviceStorage>().clearData();
      locator<NavigationService>().pop();
      // locator<NavigationService>().pushNamed(Routes.loginView);
    } catch (e) {
      rethrow;
    }
  }

  // Future<String> editProfile() async {
  //   try {
  //     // var response = await _networkService.postMethod(
  //     //   NetworkUrls.update,
  //     //   data: updatedUser.toJson(),
  //     // );
  //     // if (response.statusCode != 200) throw response;
  //     // return response.data["message"];
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
