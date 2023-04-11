import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/features/auth/domain/entities/login_credentials_entity.dart';
import 'package:verify/app/features/auth/domain/usecase/login_with_email_usecase.dart';
import 'package:verify/app/features/auth/domain/usecase/login_with_google_usecase.dart';
import 'package:verify/app/features/auth/presenter/login/store/login_store.dart';
import 'package:verify/app/features/auth/utils/email_regex.dart';
import 'package:verify/app/features/auth/utils/password_regex.dart';

class LoginController {
  // Dependency injection
  final LoginStore _loginStore;
  final LoginWithEmailUseCase _loginWithEmailUseCase;
  final LoginWithGoogleUseCase _loginWithGoogleUseCase;

  // Login page controller variables
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

  void navigateToRegisterPage() {
    Modular.to.pushReplacementNamed('./register');
  }

  /// [loginWithEmail] Esse método é responsável por chamar o caso de uso
  /// para fazer o login do usuário com email e senha.
  /// Ele cria um objeto LoginCredentialsEntity a partir
  /// dos valores dos campos de email e senha no formulário,
  /// chama o caso de uso e retorna uma mensagem de erro se houver falha.
  Future<String?> loginWithEmail() async {
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

  /// [loginWithGoogle] Esse método é responsável por chamar o caso de uso
  /// para fazer o login do usuário com o Google.
  /// Ele chama o caso de uso e retorna uma mensagem de erro se houver falha.
  Future<String?> loginWithGoogle() async {
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

  /// validateFields: Esse método é responsável por validar se os campos
  /// de email e senha no formulário estão preenchidos e em um formato válido.
  /// Ele atualiza o estado da loja LoginStore indicando se os campos
  /// são válidos ou não.
  void validateFields() {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      _loginStore.isValidFields(true);
    } else {
      _loginStore.isValidFields(false);
    }
  }

  /// [autoValidateEmail] Esse método é responsável por validar se o valor
  /// inserido no campo de email está em um formato válido.
  /// Ele é usado pelo formulário para validação automática quando
  /// o usuário digita o valor.
  String? autoValidateEmail(String? emailInput) {
    if (emailRegex.hasMatch(emailInput ?? '')) {
      return null;
    } else {
      return 'Digite um email válido';
    }
  }

  /// [autoValidatePassword] Esse método é responsável por validar se o valor
  /// inserido no campo de senha está em um formato válido.
  /// Ele é usado pelo formulário para validação automática
  /// quando o usuário digita o valor.
  String? autoValidatePassword(String? passwordInput) {
    if (passwordRegex.hasMatch(passwordInput ?? '')) {
      return null;
    } else {
      return 'Senha deve ter no minimo 8 caracteres';
    }
  }
}
