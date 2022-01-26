import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/services/network/config.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TrackerService {
  final NetworkService _networkService = locator<NetworkService>();


  // Future<bool> loginWithPassword(String email, String password) async {
  //   try {
  //     var response = await _networkService.postMethod(
  //       NetworkUrls.loginWithPassword,
  //       data: {
  //         "email": email,
  //         "password": password,
  //       },
  //     );
  //     if (response.statusCode >= 300) throw response;
  //     var responseData = LoginResponse.fromJson(response.data);
  //     await _storageService.setAccessToken(responseData.token);
  //     return true;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
