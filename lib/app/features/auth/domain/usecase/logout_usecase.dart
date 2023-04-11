import 'package:verify/app/features/auth/domain/repositories/auth_repository.dart';

abstract class LogoutUseCase {
  Future<void> call();
}

class LogoutUseCaseImpl implements LogoutUseCase {
  final AuthRepository _authRepository;

  LogoutUseCaseImpl(this._authRepository);
  @override
  Future<void> call() async {
    await _authRepository.logout();
  }
}
