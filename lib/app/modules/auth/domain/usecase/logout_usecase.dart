import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/auth/domain/errors/auth_error.dart';
import 'package:verify/app/modules/auth/domain/repositories/auth_repository.dart';

abstract class LogoutUseCase {
  Future<Result<void, AuthError>> call();
}

class LogoutUseCaseImpl implements LogoutUseCase {
  final AuthRepository _authRepository;

  LogoutUseCaseImpl(this._authRepository);
  @override
  Future<Result<void, AuthError>> call() async {
    return await _authRepository.logout();
  }
}
