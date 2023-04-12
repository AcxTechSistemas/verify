abstract class AuthError {
  String get message;
}

class ErrorSendingEmailVerification extends AuthError {
  @override
  final String message;
  ErrorSendingEmailVerification({
    required this.message,
  });
}

class ErrorRecoverAccount extends AuthError {
  @override
  final String message;
  ErrorRecoverAccount({
    required this.message,
  });
}

class ErrorGoogleLogin extends AuthError {
  @override
  final String message;
  ErrorGoogleLogin({
    required this.message,
  });
}

class ErrorLoginEmail extends AuthError {
  @override
  final String message;
  ErrorLoginEmail({
    required this.message,
  });
}

class ErrorGetLoggedUser extends AuthError {
  @override
  final String message;
  ErrorGetLoggedUser({
    required this.message,
  });
}

class ErrorLogout extends AuthError {
  @override
  final String message;
  ErrorLogout({
    required this.message,
  });
}

class ErrorRegisterEmail extends AuthError {
  @override
  final String message;
  ErrorRegisterEmail({
    required this.message,
  });
}
