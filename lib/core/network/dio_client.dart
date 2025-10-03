import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_env.dart';

class DioClient {
  DioClient._();
  static final DioClient I = DioClient._();

  final Dio dio = Dio(BaseOptions(
    baseUrl: AppEnv.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 15),
    headers: {'Content-Type': 'application/json'},
  ))
    ..interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final sp = await SharedPreferences.getInstance();
        final token = sp.getString('auth_token');
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (e, handler) {
        // تحويل رسائل الخطأ لشيء واضح للمستخدم
        final msg = e.response?.data is Map && (e.response?.data['error'] != null)
            ? e.response?.data['error'].toString()
            : e.message ?? 'Network error';
        handler.reject(DioException(
          requestOptions: e.requestOptions,
          message: msg,
          response: e.response,
          type: e.type,
        ));
      },
    ));
}
