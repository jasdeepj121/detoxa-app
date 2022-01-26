import 'package:detoxa/app/locator/locator.dart';
import 'package:detoxa/services/auth/auth_service.dart';
import 'package:detoxa/services/network/urls.dart';
import 'package:detoxa/services/storage/device_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NetworkService {
  Dio _dio;

  NetworkService() {
    _initialise();
  }

  void _initialise() {
    _dio = Dio();
    // for testing on ios for charles
    // (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (cl) => cl.findProxy = (_) => 'PROXY 192.168.0.102:8888';
    setBaseUrl(NetworkUrls.baseUrlProd);
    _setupInterceptor();
  }

  Future updateToken(String newToken) async {
    await locator<DeviceStorage>().setAccessToken(newToken);
  }

  String get accessToken => locator<DeviceStorage>().accessToken ?? "";

  void _setupInterceptor() {
    _dio.interceptors.clear();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          if (accessToken != null) {
            options.headers["Authorization"] = accessToken;
          }
          return handler.next(options);
        },
        onError: (DioError error, ErrorInterceptorHandler errorHandler) async {
          // if (error.response?.statusCode == 401) {
          //   try {
          //     _dio.interceptors.requestLock.lock();
          //     _dio.interceptors.responseLock.lock();
          //     RequestOptions options = error.response.requestOptions;
          //     await updateToken(error.response.data["data"]["access_token"]);
          //     options.headers["Authorization"] = "Bearer $accessToken";
          //     _dio.interceptors.requestLock.unlock();
          //     _dio.interceptors.responseLock.unlock();
          //     Response apiResponse;
          //     if (error.requestOptions.method == "GET") {
          //       apiResponse = await _dio.get(options.path);
          //     } else if (error.requestOptions.method == "POST") {
          //       apiResponse = await _dio.post(options.path, data: options.data);
          //     } else if (error.requestOptions.method == "PATCH") {
          //       apiResponse =
          //           await _dio.patch(options.path, data: options.data);
          //     }
          //     return errorHandler.resolve(apiResponse);
          //   } catch (e) {
          //     _dio.interceptors.requestLock.unlock();
          //     _dio.interceptors.responseLock.unlock();
          //     print("inside catch of refresh token");
          //     return errorHandler.next(error);
          //   }
          // } else if (error.response?.statusCode == 403) {
          //   //force log out
          //   locator<AuthService>().logout();
          //   // errorHandler.next(error);
          // }
          errorHandler.next(error);
        },
      ),
    );
  }

  void setBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  Future<Response> getMethod(String url,
      {Map<String, dynamic> queryParameters}) {
    return _dio.get(
      url,
      queryParameters: queryParameters,
    );
  }

  Future<Response> postMethod(String url,
      {dynamic data, Map<String, dynamic> queryParameters}) {
    return _dio.post(
      url,
      queryParameters: queryParameters,
      data: data,
    );
  }

  Future<Response> patchMethod(String url,
      {dynamic data, Map<String, dynamic> queryParameters}) {
    return _dio.patch(
      url,
      queryParameters: queryParameters,
      data: data,
    );
  }

  Future<Response> deleteMethod(String url,
      {dynamic data, Map<String, dynamic> queryParameters}) {
    return _dio.delete(
      url,
      queryParameters: queryParameters,
      data: data,
    );
  }

  Future<Response> download(
    String url,
    String savePath, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Function(int, int) onReceiveProgress,
  }) {
    return _dio.download(
      url,
      savePath,
      data: data,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      deleteOnError: true,
    );
  }

  void cancelAll() {
    return _dio.close(force: true);
  }
}
