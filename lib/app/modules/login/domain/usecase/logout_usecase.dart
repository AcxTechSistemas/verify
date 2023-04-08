import 'package:verify/app/modules/login/domain/repositories/login_repository.dart';

abstract class LogoutUseCase {
  Future<void> call();
}

class LogoutUseCaseImpl implements LogoutUseCase {
  final LoginRepository _loginRepository;

  LogoutUseCaseImpl(this._loginRepository);
  @override
  Future<void> call() async {
    await _loginRepository.logout();
  }
}
