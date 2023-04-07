import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/login/domain/entities/logged_user_info.dart';
import 'package:verify/app/modules/login/domain/entities/login_credentials_entity.dart';
import 'package:verify/app/modules/login/domain/errors/login_error.dart';

abstract class LoginRepository {
  Future<Result<LoggedUserInfoEntity, LoginError>> loginWithEmail(
    LoginCredentialsEntity loginCredentialsEntity,
  );

  Future<Result<LoggedUserInfoEntity, LoginError>> loginWithGoogle();
}
