class RegisterCredentialsEntity {
  final String _email;
  final String _password;
  final String _confirmPassword;

  RegisterCredentialsEntity({
    required String email,
    required String password,
    required String confirmPassword,
  })  : _email = email,
        _password = password,
        _confirmPassword = confirmPassword;

  /// Validate email
  final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  bool get isValidEmail => _emailRegex.hasMatch(_email);

  /// Validate Password
  bool get isValidPassword => _password.isNotEmpty && _password.length >= 8;

  /// Validate Password Equality
  bool get isPasswordEquality => _password == _confirmPassword;

  String get email => _email;

  String get password => _password;

  String get confirmPassword => _confirmPassword;
}
