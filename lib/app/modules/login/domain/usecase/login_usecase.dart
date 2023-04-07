import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/login/domain/entities/logged_user_info.dart';
import 'package:verify/app/modules/login/domain/entities/login_credentials_entity.dart';
import 'package:verify/app/modules/login/domain/errors/login_error.dart';
import 'package:verify/app/modules/login/domain/repositories/login_repository.dart';

abstract class LoginUseCase {
  Future<Result<LoggedUserInfoEntity, LoginError>> loginWithEmail(
    LoginCredentialsEntity loginCredentialsEntity,
  );
  Future<Result<LoggedUserInfoEntity, LoginError>> loginWithGoogle();
}

class LoginUseCaseImpl implements LoginUseCase {
  final LoginRepository _loginRepository;
  LoginUseCaseImpl(this._loginRepository);

  @override
  Future<Result<LoggedUserInfoEntity, LoginError>> loginWithEmail(
    LoginCredentialsEntity loginCredentialsEntity,
  ) async {
    if (!loginCredentialsEntity.isValidEmail) {
      return Failure(ErrorLoginEmail(message: 'invalid-email'));
    } else if (!loginCredentialsEntity.isValidPassword) {
      return Failure(ErrorLoginEmail(message: 'invalid-password'));
    }

    final result = await _loginRepository.loginWithEmail(
      loginCredentialsEntity,
    );
    return result;
  }

  @override
  Future<Result<LoggedUserInfoEntity, LoginError>> loginWithGoogle() async {
    return _loginRepository.loginWithGoogle();
  }
}
