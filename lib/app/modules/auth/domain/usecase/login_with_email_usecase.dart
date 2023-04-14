import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/auth/domain/entities/logged_user_info.dart';
import 'package:verify/app/modules/auth/domain/entities/login_credentials_entity.dart';
import 'package:verify/app/modules/auth/domain/errors/auth_error.dart';
import 'package:verify/app/modules/auth/domain/repositories/auth_repository.dart';

abstract class LoginWithEmailUseCase {
  Future<Result<LoggedUserInfoEntity, AuthError>> call(
    LoginCredentialsEntity loginCredentialsEntity,
  );
}

class LoginWithEmailUseCaseImpl implements LoginWithEmailUseCase {
  final AuthRepository _authRepository;
  LoginWithEmailUseCaseImpl(this._authRepository);

  @override
  Future<Result<LoggedUserInfoEntity, AuthError>> call(
    LoginCredentialsEntity loginCredentialsEntity,
  ) async {
    if (!loginCredentialsEntity.isValidEmail) {
      return Failure(ErrorLoginEmail(message: 'invalid-email'));
    } else if (!loginCredentialsEntity.isValidPassword) {
      return Failure(ErrorLoginEmail(message: 'invalid-password'));
    }

    final result = await _authRepository.loginWithEmail(
      email: loginCredentialsEntity.email,
      password: loginCredentialsEntity.password,
    );
    return result;
  }
}
