import 'package:dio/dio.dart';


class DioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio();
  }

  static Future<Response?> get({
    required String endPoint,
  }) async {
    try {
      Response? response = await dio?.get(
        endPoint
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
