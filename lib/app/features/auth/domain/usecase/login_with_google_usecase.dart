import 'package:result_dart/result_dart.dart';
import 'package:verify/app/features/auth/domain/entities/logged_user_info.dart';
import 'package:verify/app/features/auth/domain/errors/auth_error.dart';
import 'package:verify/app/features/auth/domain/repositories/auth_repository.dart';

abstract class LoginWithGoogleUseCase {
  Future<Result<LoggedUserInfoEntity, AuthError>> call();
}

class LoginWithGoogleImpl implements LoginWithGoogleUseCase {
  final AuthRepository _authRepository;
  LoginWithGoogleImpl(this._authRepository);

  @override
  Future<Result<LoggedUserInfoEntity, AuthError>> call() async {
    return _authRepository.loginWithGoogle();
  }
}
