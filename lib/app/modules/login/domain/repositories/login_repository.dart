import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/login/domain/entities/logged_user_info.dart';
import 'package:verify/app/modules/login/domain/errors/login_error.dart';

abstract class LoginRepository {
  Future<Result<LoggedUserInfoEntity, LoginError>> loginWithEmail({
    required String email,
    required String password,
  });

  Future<Result<LoggedUserInfoEntity, LoginError>> loginWithGoogle();
  Future<void> logout();
  Future<Result<LoggedUserInfoEntity, LoginError>> loggedUser();
}
