import 'dart:ffi';

import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/auth/domain/errors/auth_error.dart';
import 'package:verify/app/modules/auth/domain/entities/logged_user_info.dart';
import 'package:verify/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:verify/app/modules/auth/infra/datasource/auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;
  AuthRepositoryImpl(this._authDataSource);

  @override
  Future<LoggedUserInfoEntity?> loggedUser() async {
    final user = await _authDataSource.currentUser();
    return user;
  }

  @override
  Future<Result<LoggedUserInfoEntity, AuthError>> loginWithGoogle() async {
    try {
      final user = await _authDataSource.loginWithGoogle();
      return Success(user);
    } on ErrorGoogleLogin catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(ErrorGoogleLogin(
        message: 'Ocorreu um erro ao realizar o login. Tente novamente',
      ));
    }
  }

  @override
  Future<Result<LoggedUserInfoEntity, AuthError>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _authDataSource.loginWithEmail(
        email: email,
        password: password,
      );
      return Success(user);
    } on ErrorLoginEmail catch (e) {
      return Failure(e);
    } on ErrorSendingEmailVerification catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(ErrorLoginEmail(
        message: 'Ocorreu um erro ao realizar o login. Tente novamente',
      ));
    }
  }

  @override
  Future<Result<void, AuthError>> logout() async {
    try {
      await _authDataSource.logout();
      return const Success(Void);
    } on ErrorLogout catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(ErrorRegisterEmail(
        message: 'Ocorreu um erro ao criar uma nova conta. Tente novamente',
      ));
    }
  }

  @override
  Future<Result<LoggedUserInfoEntity, AuthError>> registerWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _authDataSource.registerWithEmail(
        email: email,
        password: password,
      );
      return Success(user);
    } on ErrorRegisterEmail catch (e) {
      return Failure(e);
    } on ErrorSendingEmailVerification catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(ErrorRegisterEmail(
        message: 'Ocorreu um erro ao criar uma nova conta. Tente novamente',
      ));
    }
  }

  @override
  Future<Result<void, AuthError>> sendRecoverInstructions({
    required String email,
  }) async {
    try {
      await _authDataSource.sendRecoverInstructions(email: email);
      return const Success(Void);
    } on ErrorRecoverAccount catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(ErrorRecoverAccount(
        message: 'Ocorreu um erro ao criar uma nova conta. Tente novamente',
      ));
    }
  }
}
