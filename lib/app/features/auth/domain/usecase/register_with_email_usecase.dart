import 'package:result_dart/result_dart.dart';
import 'package:verify/app/features/auth/domain/entities/logged_user_info.dart';
import 'package:verify/app/features/auth/domain/entities/register_credentials_entity.dart';
import 'package:verify/app/features/auth/domain/errors/auth_error.dart';
import 'package:verify/app/features/auth/domain/repositories/auth_repository.dart';

abstract class RegisterWithEmailUseCase {
  Future<Result<LoggedUserInfoEntity, AuthError>> call(
    RegisterCredentialsEntity registerCredentialsEntity,
  );
}

class RegisterWithEmailUseCaseImpl implements RegisterWithEmailUseCase {
  final AuthRepository _authRepository;
  RegisterWithEmailUseCaseImpl(this._authRepository);

  @override
  Future<Result<LoggedUserInfoEntity, AuthError>> call(
    RegisterCredentialsEntity registerCredentialsEntity,
  ) async {
    if (!registerCredentialsEntity.isValidEmail) {
      return Failure(ErrorLoginEmail(message: 'invalid-email'));
    } else if (!registerCredentialsEntity.isValidPassword) {
      return Failure(ErrorLoginEmail(message: 'invalid-password'));
    } else if (!registerCredentialsEntity.isPasswordEquality) {
      return Failure(ErrorLoginEmail(message: 'not-password-equality'));
    }

    final result = await _authRepository.registerWithEmail(
      email: registerCredentialsEntity.email,
      password: registerCredentialsEntity.password,
    );
    return result;
  }
}
