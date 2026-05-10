abstract class AppExceptions implements Exception {
  final String message;
  final int? statusCode;

  const AppExceptions({required this.message, required this.statusCode});
}

class ServerExceptions extends AppExceptions {
  const ServerExceptions({required super.message, super.statusCode});
}

class NetworkExceptions extends AppExceptions {
  const NetworkExceptions({required super.message, super.statusCode});
}

class UnExpectedError extends AppExceptions {
  UnExpectedError({required super.message, super.statusCode});
}
