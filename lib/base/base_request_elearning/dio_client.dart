import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/services_elearning/apis/auth/login/models/login_response.dart';

import '../author/author_manager.dart';

class DioClient{
  static final DioClient _singletonDioClient = DioClient._internal();
  static DioClient get getInstance => _singletonDioClient;
  factory DioClient() {
    return _singletonDioClient;
  }
  DioClient._internal();
  Dio dio = Dio();
  void initial(){
    BaseOptions options = BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60), // 30 seconds
      receiveTimeout: const Duration(seconds: 60), // 30 seconds
    );
    dio = Dio(options);
    
  }
  Dio getDioClient(){
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add the access token to the request header
          AuthInfo? authInfo = AuthorManager().getAuthInfo();

          if(authInfo!=null)
          {
            options.headers['Authorization'] = 'Bearer ${authInfo.accessToken}';

          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            // If a 401 response is received, refresh the access token
           // String newAccessToken = await refreshToken();

            // Update the request header with the new access token
           // e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

            // Repeat the request with the updated header
            return handler.resolve(await dio.fetch(e.requestOptions));
          }
          return handler.next(e);
        },
      ),
    );
    return dio;
  }
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}