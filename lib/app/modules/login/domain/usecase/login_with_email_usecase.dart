import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/login/domain/entities/logged_user_info.dart';
import 'package:verify/app/modules/login/domain/entities/login_credentials_entity.dart';
import 'package:verify/app/modules/login/domain/errors/login_error.dart';
import 'package:verify/app/modules/login/domain/repositories/login_repository.dart';

abstract class LoginWithEmailUseCase {
  Future<Result<LoggedUserInfoEntity, LoginError>> call(
    LoginCredentialsEntity loginCredentialsEntity,
  );
}

class LoginWithEmailUseCaseImpl implements LoginWithEmailUseCase {
  final LoginRepository _loginRepository;
  LoginWithEmailUseCaseImpl(this._loginRepository);

  @override
  Future<Result<LoggedUserInfoEntity, LoginError>> call(
    LoginCredentialsEntity loginCredentialsEntity,
  ) async {
    if (!loginCredentialsEntity.isValidEmail) {
      return Failure(ErrorLoginEmail(message: 'invalid-email'));
    } else if (!loginCredentialsEntity.isValidPassword) {
      return Failure(ErrorLoginEmail(message: 'invalid-password'));
    }

    final result = await _loginRepository.loginWithEmail(
      email: loginCredentialsEntity.email,
      password: loginCredentialsEntity.password,
    );
    return result;
  }
}
