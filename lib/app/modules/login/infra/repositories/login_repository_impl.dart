import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/login/domain/errors/login_error.dart';
import 'package:verify/app/modules/login/domain/entities/logged_user_info.dart';
import 'package:verify/app/modules/login/domain/repositories/login_repository.dart';
import 'package:verify/app/modules/login/infra/datasource/login_datasource.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource _loginDataSource;
  LoginRepositoryImpl(this._loginDataSource);

  @override
  Future<Result<LoggedUserInfoEntity, LoginError>> loggedUser() async {
    try {
      final user = await _loginDataSource.currentUser();
      return Success(user);
    } catch (e) {
      return Failure(ErrorGetLoggedUser(
          message: 'Error when trying to retrieve current logged in user'));
    }
  }

  @override
  Future<Result<LoggedUserInfoEntity, LoginError>> loginWithGoogle() async {
    try {
      final user = await _loginDataSource.loginWithGoogle();
      return Success(user);
    } catch (e) {
      return Failure(ErrorGoogleLogin(message: 'error-login-with-google'));
    }
  }

  @override
  Future<Result<LoggedUserInfoEntity, LoginError>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _loginDataSource.loginWithEmail(
        email: email,
        password: password,
      );
      return Success(user);
    } catch (e) {
      return Failure(ErrorLoginEmail(message: 'error-login-with-email'));
    }
  }

  @override
  Future<void> logout() async {
    await _loginDataSource.logout();
  }
}
