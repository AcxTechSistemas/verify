import 'package:result_dart/result_dart.dart';
import 'package:verify/app/features/auth/domain/errors/auth_error.dart';
import 'package:verify/app/features/auth/domain/repositories/auth_repository.dart';

abstract class RecoverAccountUseCase {
  Future<Result<void, AuthError>> call({required String email});
}

class RecoverAccountUseCaseImpl implements RecoverAccountUseCase {
  final AuthRepository _authRepository;
  RecoverAccountUseCaseImpl(this._authRepository);
  @override
  Future<Result<void, AuthError>> call({required String email}) async {
    return await _authRepository.sendRecoverInstructions(email: email);
  }
}
