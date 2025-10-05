import 'package:dio/dio.dart';

// إذا عندك AppEnv جاهز استعمله، وإلا خليك على الـ baseUrl هون
const _kBaseUrl = 'https://reqres.in/api';

class DioClient {
  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: _kBaseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        headers: const {
          'Content-Type': 'application/json',
        },
      ),
    );

    // Interceptor بسيط لوجينغ (اختياري)
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // print('[REQ] ${options.method} ${options.uri}');
          handler.next(options);
        },
        onError: (e, handler) {
          // print('[ERR] ${e.response?.statusCode} ${e.message}');
          handler.next(e);
        },
      ),
    );
  }

  // الـ singleton ↓↓↓
  static final DioClient I = DioClient._internal();

  late final Dio dio;
}
