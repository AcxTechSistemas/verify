import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/login/domain/entities/logged_user_info.dart';
import 'package:verify/app/modules/login/domain/errors/login_error.dart';
import 'package:verify/app/modules/login/domain/repositories/login_repository.dart';

abstract class LoginWithGoogleUseCase {
  Future<Result<LoggedUserInfoEntity, LoginError>> call();
}

class LoginWithGoogleImpl implements LoginWithGoogleUseCase {
  final LoginRepository _loginRepository;
  LoginWithGoogleImpl(this._loginRepository);

  @override
  Future<Result<LoggedUserInfoEntity, LoginError>> call() async {
    return _loginRepository.loginWithGoogle();
  }
}
