import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/login/entities/logged_user_info.dart';
import 'package:verify/app/modules/login/errors/login_error.dart';
import 'package:verify/app/modules/login/repositories/login_with_google_repository.dart';

abstract class LoginWithGoogleUseCase {
  Future<Result<LoggedUserInfoEntity, LoginError>> call();
}

class LoginWithGoogleUseCaseImpl implements LoginWithGoogleUseCase {
  final LoginWithGoogleRepository _loginWithGoogleRepository;
  LoginWithGoogleUseCaseImpl(this._loginWithGoogleRepository);
  @override
  Future<Result<LoggedUserInfoEntity, LoginError>> call() {
    return _loginWithGoogleRepository();
  }
}
