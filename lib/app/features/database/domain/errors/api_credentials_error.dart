abstract class ApiCredentialsError implements Exception {
  String get message;
}

class ErrorSavingApiCredentials extends ApiCredentialsError {
  @override
  final String message;
  ErrorSavingApiCredentials({required this.message});
}

class ErrorUpdateApiCredentials extends ApiCredentialsError {
  @override
  final String message;
  ErrorUpdateApiCredentials({required this.message});
}

class ErrorReadingApiCredentials extends ApiCredentialsError {
  @override
  final String message;
  ErrorReadingApiCredentials({required this.message});
}

class ErrorRemovingApiCredentials extends ApiCredentialsError {
  @override
  final String message;
  ErrorRemovingApiCredentials({required this.message});
}
