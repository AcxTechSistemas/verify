import 'package:result_dart/result_dart.dart';
import 'package:verify/app/features/auth/domain/entities/logged_user_info.dart';
import 'package:verify/app/features/auth/domain/errors/auth_error.dart';
import 'package:verify/app/features/auth/domain/repositories/auth_repository.dart';

abstract class GetLoggedUserUseCase {
  Future<Result<LoggedUserInfoEntity, AuthError>> call();
}

class GetLoggedUserUseCaseImpl implements GetLoggedUserUseCase {
  final AuthRepository _authRepository;

  GetLoggedUserUseCaseImpl(this._authRepository);
  @override
  Future<Result<LoggedUserInfoEntity, AuthError>> call() async {
    return await _authRepository.loggedUser();
  }
}
