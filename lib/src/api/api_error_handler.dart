import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:weatherforecastflutter/src/models/api_error.dart';

class ApiErrorHandler {
  static Future<ApiError> getErrorMessage(Object obj) async {
    switch (obj.runtimeType) {
      case DioError:
        // Get the failed response error code and message from Dio
        final res = (obj as DioError).response;
        if (res != null) {
          switch (res.statusCode) {
            case 400:
            case 403:
              Map<String, dynamic> error = jsonDecode(res.data);
              return ApiError(
                  code: res.statusCode,
                  message: error['message']);
            case 404:
              return ApiError(
                  code: res.statusCode,
                  message: "Error getting data. Please try again later.");
            default:
              return ApiError(
                  code: res.statusCode,
                  message: Exception(res.data).toString());
          }
        } else {
          ApiError(code: 0, message: obj.runtimeType.toString());
        }

        break;
      default:
        print("ApiErrorHandler: " + obj.toString());
        return ApiError(code: 0, message: "Unknown error. Please try again later.");
        break;
    }
    print("ApiErrorHandler: " + obj.toString());
    return ApiError(code: 0, message: "Unknown error. Please try again later.");
  }
}
