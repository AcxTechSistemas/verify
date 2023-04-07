import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/login/domain/entities/logged_user_info.dart';
import 'package:verify/app/modules/login/domain/errors/login_error.dart';

abstract class LoginWithGoogleRepository {
  Future<Result<LoggedUserInfoEntity, LoginError>> call();
}
