import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/login/domain/errors/login_error.dart';
import 'package:verify/app/modules/login/domain/entities/login_credentials_entity.dart';
import 'package:verify/app/modules/login/domain/entities/logged_user_info.dart';
import 'package:verify/app/modules/login/domain/repositories/login_repository.dart';
import 'package:verify/app/modules/login/infra/datasource/login_datasource.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource _loginDataSource;
  LoginRepositoryImpl(this._loginDataSource);

  @override
  Future<Result<LoggedUserInfoEntity, LoginError>> loginWithEmail(
    LoginCredentialsEntity loginCredentialsEntity,
  ) async {
    try {
      final user = await _loginDataSource.loginWithEmail(
        loginCredentialsEntity,
      );
      return Success(user);
    } catch (e) {
      return Failure(ErrorLoginEmail(message: 'error-login-with-email'));
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
}
