import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/dataModels/child.dart';
import 'package:detoxa/dataModels/gender.dart';
import 'package:detoxa/dataModels/new_growth_tracker.dart';
import 'package:detoxa/services/network/config.dart';
import 'package:detoxa/services/network/urls.dart';
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

  Future<NewGrowthTrackerReport> createGrowthTracker({
    Child child,
    int height,
    int weight,
    int age,
  }) async {
    try {
      var response = await _networkService.postMethod(
        NetworkUrls.createGrowthTracker,
        data: {
          "child": child.id,
          "height": height,
          "weight": weight,
          "age": age,
          "gender": child.gender == Gender.male
              ? "Male"
              : child.gender == Gender.female
                  ? "Female"
                  : "Others",
        },
      );
      var newGrowth = NewGrowthTrackerReport.fromJson(response.data["data"]);
      return newGrowth;
    } catch (e) {
      rethrow;
    }
  }

  Future getGrowthTrackerList() async {
    try {
      var response = await _networkService.getMethod(
        NetworkUrls.getGrowthTrackerList,
      );
      print(response.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  Future downloadGrowthTrackerResult(int childId, int reportId) async {
    try {
      var response = await _networkService
          .postMethod(NetworkUrls.downloadGrowthReport, data: {
        "child_user": childId,
        "report_id": reportId,
        "interpretations": "",
        "note_1": "",
        "note_2": ""
      });
      print(response.toString());
    } catch (e) {
      print(e.toString());
    }
  }
}
