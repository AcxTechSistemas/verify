abstract class LoginError {
  String get message;
}

class ErrorGoogleLogin extends LoginError {
  @override
  final String message;
  ErrorGoogleLogin({
    required this.message,
  });
}

class ErrorLoginEmail extends LoginError {
  @override
  final String message;
  ErrorLoginEmail({
    required this.message,
  });
}

class ErrorGetLoggedUser extends LoginError {
  @override
  final String message;
  ErrorGetLoggedUser({
    required this.message,
  });
}

class ErrorLogout extends LoginError {
  @override
  final String message;
  ErrorLogout({
    required this.message,
  });
}

class InternalError extends LoginError {
  @override
  final String message;
  InternalError({
    required this.message,
  });
}
