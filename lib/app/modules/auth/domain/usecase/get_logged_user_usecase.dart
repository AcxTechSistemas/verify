import 'package:verify/app/modules/auth/domain/entities/logged_user_info.dart';
import 'package:verify/app/modules/auth/domain/repositories/auth_repository.dart';

abstract class GetLoggedUserUseCase {
  Future<LoggedUserInfoEntity?> call();
}

class GetLoggedUserUseCaseImpl implements GetLoggedUserUseCase {
  final AuthRepository _authRepository;

  GetLoggedUserUseCaseImpl(this._authRepository);
  @override
  Future<LoggedUserInfoEntity?> call() async {
    return await _authRepository.loggedUser();
  }
}
