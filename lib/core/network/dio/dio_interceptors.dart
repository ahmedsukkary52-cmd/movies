import 'package:dio/dio.dart';
import 'package:moives/core/errors/exceptions.dart';

class DioInterceptors extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppExceptions appExceptions;
    final responseData = err.response?.data;
    String message = 'Something went wrong';
    if (responseData is Map) {
      message =
          (responseData['errors']?['msg'] as String?) ??
          (responseData['message'] as String?) ??
          message;
    }
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout) {
      appExceptions = NetworkExceptions(message: 'No Internet Connection');
    } else if (err.response?.statusCode != null) {
      appExceptions = ServerExceptions(
        message: 'Server Error',
        statusCode: err.response?.statusCode,
      );
    } else {
      appExceptions = UnExpectedError(message: message);
    }
    handler.next(
      DioException(requestOptions: err.requestOptions, error: appExceptions),
    );
  }
}
