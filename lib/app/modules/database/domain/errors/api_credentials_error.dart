// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class ApiCredentialsError implements Exception {
  String get message;
}

class EmptyApiCredentials extends ApiCredentialsError {
  @override
  final String message;
  EmptyApiCredentials({required this.message});

  @override
  String toString() => 'EmptyApiCredentials(message: $message)';
}

class ErrorSavingApiCredentials extends ApiCredentialsError {
  @override
  final String message;
  ErrorSavingApiCredentials({required this.message});

  @override
  String toString() => 'ErrorSavingApiCredentials(message: $message)';
}

class ErrorUpdateApiCredentials extends ApiCredentialsError {
  @override
  final String message;
  ErrorUpdateApiCredentials({required this.message});

  @override
  String toString() => 'ErrorUpdateApiCredentials(message: $message)';
}

class ErrorReadingApiCredentials extends ApiCredentialsError {
  @override
  final String message;
  ErrorReadingApiCredentials({required this.message});

  @override
  String toString() => 'ErrorReadingApiCredentials(message: $message)';
}

class ErrorRemovingApiCredentials extends ApiCredentialsError {
  @override
  final String message;
  ErrorRemovingApiCredentials({required this.message});

  @override
  String toString() => 'ErrorRemovingApiCredentials(message: $message)';
}
