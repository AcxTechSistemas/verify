import 'package:verify/app/modules/auth/utils/email_regex.dart';
import 'package:verify/app/modules/auth/utils/password_regex.dart';

class LoginCredentialsEntity {
  final String _email;
  final String _password;

  LoginCredentialsEntity({
    required String email,
    required String password,
  })  : _email = email,
        _password = password;

  /// Validate email
  bool get isValidEmail => emailRegex.hasMatch(_email);

  /// Validate Password
  bool get isValidPassword => passwordRegex.hasMatch(_password);

  String get email => _email;

  String get password => _password;
}
