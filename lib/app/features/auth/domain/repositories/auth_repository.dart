import 'package:result_dart/result_dart.dart';
import 'package:verify/app/features/auth/domain/entities/logged_user_info.dart';
import 'package:verify/app/features/auth/domain/errors/auth_error.dart';

abstract class AuthRepository {
  Future<Result<LoggedUserInfoEntity, AuthError>> registerWithEmail({
    required String email,
    required String password,
  });

  Future<Result<LoggedUserInfoEntity, AuthError>> loginWithEmail({
    required String email,
    required String password,
  });

  Future<Result<LoggedUserInfoEntity, AuthError>> loginWithGoogle();
  Future<void> logout();
  Future<Result<LoggedUserInfoEntity, AuthError>> loggedUser();
}
