import 'package:dio/dio.dart';

class DioManager {
  factory DioManager() {
    return _instance;
  }

  DioManager._init();
  static final DioManager _instance = DioManager._init();
  static Dio? _dio;

  Dio get dio {
    if (_dio == null) {
      throw Exception('DioManager.init() çağrılmadan dio kullanılamaz!');
    }
    return _dio!;
  }
  Future<void> init() async {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio!.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true, 
      ),
    );
  }
}