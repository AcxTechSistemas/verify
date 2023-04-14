import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/modules/auth/domain/entities/login_credentials_entity.dart';
import 'package:verify/app/modules/auth/domain/usecase/login_with_email_usecase.dart';
import 'package:verify/app/modules/auth/domain/usecase/login_with_google_usecase.dart';
import 'package:verify/app/modules/auth/presenter/login/store/login_store.dart';
import 'package:verify/app/modules/auth/utils/email_regex.dart';
import 'package:verify/app/modules/auth/utils/password_regex.dart';

class LoginController {
  final LoginStore _loginStore;
  final LoginWithEmailUseCase _loginWithEmailUseCase;
  final LoginWithGoogleUseCase _loginWithGoogleUseCase;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  LoginController(
    this._loginStore,
    this._loginWithEmailUseCase,
    this._loginWithGoogleUseCase,
  );

  void goToRegisterPage() {
    dispose();
    Modular.to.pushReplacementNamed('./register');
  }

  void goToRecoverAccountPage() {
    dispose();
    Modular.to.pushReplacementNamed('./recover');
  }

  Future<String?> loginWithEmail() async {
    emailFocus.unfocus();
    passwordFocus.unfocus();
    _loginStore.loggingInWithEmailInProgress(true);
    final loginCredentials = LoginCredentialsEntity(
      email: emailController.text,
      password: passwordController.text,
    );

    final result = await _loginWithEmailUseCase(loginCredentials);

    return result.fold(
      (user) {
        if (!user.emailVerified) {
          _loginStore.loggingInWithEmailInProgress(false);
          return 'Confirme seu email no link enviado';
        }

        _loginStore.loggingInWithEmailInProgress(false);
        return null;
      },
      (failure) {
        _loginStore.loggingInWithEmailInProgress(false);
        return failure.message;
      },
    );
  }

  Future<String?> loginWithGoogle() async {
    emailFocus.unfocus();
    passwordFocus.unfocus();
    _loginStore.loggingInWithGoogleInProgress(true);
    final result = await _loginWithGoogleUseCase.call();

    return result.fold(
      (success) {
        _loginStore.loggingInWithGoogleInProgress(false);
        return null;
      },
      (failure) {
        _loginStore.loggingInWithGoogleInProgress(false);
        return failure.message;
      },
    );
  }

  void validateFields() {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      _loginStore.isValidFields(true);
    } else {
      _loginStore.isValidFields(false);
    }
  }

  String? autoValidateEmail(String? emailInput) {
    if (emailRegex.hasMatch(emailInput ?? '')) {
      return null;
    } else {
      return 'Digite um email válido';
    }
  }

  String? autoValidatePassword(String? passwordInput) {
    if (passwordRegex.hasMatch(passwordInput ?? '')) {
      return null;
    } else {
      return 'Senha deve ter no minimo 8 caracteres';
    }
  }

  void dispose() {
    emailController.text = '';
    passwordController.text = '';
    _loginStore.isValidFields(false);
    _loginStore.loggingInWithEmailInProgress(false);
    _loginStore.loggingInWithGoogleInProgress(false);
  }
}
