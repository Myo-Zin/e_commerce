
import 'package:dio/dio.dart';

import 'failure.dart';

class DioException implements Exception{
  late Failure failure;

  DioException.fromDioError(DioError dioError){
    switch (dioError.type) {
      case DioErrorType.cancel:
        failure = Failure("Request to API server was cancelled");
        break;
      case DioErrorType.connectionTimeout:
        failure = Failure("Connection timeout ");
        break;
      case DioErrorType.unknown:
        failure = Failure("No internet connection");
        break;
      case DioErrorType.receiveTimeout:
        failure = Failure("Receive timeout in connection with API server");
        break;
      case DioErrorType.badResponse:
        failure = _handleError(dioError.response!);
        break;
      case DioErrorType.sendTimeout:
        failure = Failure("Connection timeout ");
        break;
      default:
        failure = Failure("Something went wrong");
        break;
    }
  }
  Failure _handleError(Response response) {
    try {
      final msg = response.data?["message"];
      return Failure(msg ?? "Oops something went wrong");
    } catch (e) {
      return Failure(response.data.toString());
    }
  }

  @override
  String toString() => failure.message;
}