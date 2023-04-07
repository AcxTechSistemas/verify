class LoginCredentialsEntity {
  final String _email;
  final String _password;

  LoginCredentialsEntity({
    required String email,
    required String password,
  })  : _email = email,
        _password = password;

  /// Validate email
  final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  bool get isValidEmail => _emailRegex.hasMatch(_email);

  /// Validate Password
  bool get isValidPassword => _password.isNotEmpty && _password.length >= 8;
}
