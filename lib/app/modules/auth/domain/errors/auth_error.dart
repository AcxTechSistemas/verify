// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class AuthError implements Exception {
  String get message;
}

class ErrorSendingEmailVerification extends AuthError {
  @override
  final String message;
  ErrorSendingEmailVerification({
    required this.message,
  });
  @override
  String toString() => 'ErrorSendingEmailVerification(message: $message)';
}

class ErrorRecoverAccount extends AuthError {
  @override
  final String message;
  ErrorRecoverAccount({
    required this.message,
  });
  @override
  String toString() => 'ErrorRecoverAccount(message: $message)';
}

class ErrorGoogleLogin extends AuthError {
  @override
  final String message;
  ErrorGoogleLogin({
    required this.message,
  });
  @override
  String toString() => 'ErrorGoogleLogin(message: $message)';
}

class ErrorLoginEmail extends AuthError {
  @override
  final String message;
  ErrorLoginEmail({
    required this.message,
  });
  @override
  String toString() => 'ErrorLoginEmail(message: $message)';
}

class ErrorGetLoggedUser extends AuthError {
  @override
  final String message;
  ErrorGetLoggedUser({
    required this.message,
  });
  @override
  String toString() => 'ErrorGetLoggedUser(message: $message)';
}

class ErrorLogout extends AuthError {
  @override
  final String message;
  ErrorLogout({
    required this.message,
  });

  @override
  String toString() => 'ErrorLogout(message: $message)';
}

class ErrorRegisterEmail extends AuthError {
  @override
  final String message;
  ErrorRegisterEmail({
    required this.message,
  });

  @override
  String toString() => 'ErrorRegisterEmail(message: $message)';
}
