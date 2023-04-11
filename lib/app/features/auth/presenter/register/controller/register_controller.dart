import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/features/auth/domain/entities/register_credentials_entity.dart';
import 'package:verify/app/features/auth/domain/usecase/login_with_google_usecase.dart';
import 'package:verify/app/features/auth/domain/usecase/register_with_email_usecase.dart';
import 'package:verify/app/features/auth/presenter/register/store/register_store.dart';
import 'package:verify/app/features/auth/utils/email_regex.dart';
import 'package:verify/app/features/auth/utils/password_regex.dart';

class RegisterController {
  // Dependency injection
  final RegisterStore _registerStore;
  final RegisterWithEmailUseCase _registerWithEmailUseCase;
  final LoginWithGoogleUseCase _loginWithGoogleUseCase;

  // Register page controller variables
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();

  RegisterController(
    this._registerStore,
    this._registerWithEmailUseCase,
    this._loginWithGoogleUseCase,
  );

  void backToLoginPage() {
    Modular.to.pushReplacementNamed('./login');
  }

  /// [loginWithEmail] Esse método é responsável por chamar o caso de uso
  /// para fazer o login do usuário com email e senha.
  /// Ele cria um objeto LoginCredentialsEntity a partir
  /// dos valores dos campos de email e senha no formulário,
  /// chama o caso de uso e retorna uma mensagem de erro se houver falha.
  Future<String?> registerWithEmail() async {
    _registerStore.registeringWithEmailInProgress(true);
    final registerCredentials = RegisterCredentialsEntity(
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
    );
    final result = await _registerWithEmailUseCase(registerCredentials);

    return result.fold(
      (success) {
        _registerStore.registeringWithEmailInProgress(false);
        return null;
      },
      (failure) {
        _registerStore.registeringWithEmailInProgress(false);
        return failure.message;
      },
    );
  }

  /// [loginWithGoogle] Esse método é responsável por chamar o caso de uso
  /// para fazer o login do usuário com o Google.
  /// Ele chama o caso de uso e retorna uma mensagem de erro se houver falha.
  Future<String?> loginWithGoogle() async {
    _registerStore.registeringWithGoogleInProgress(true);
    final result = await _loginWithGoogleUseCase.call();

    return result.fold(
      (success) {
        _registerStore.registeringWithGoogleInProgress(false);
        return null;
      },
      (failure) {
        _registerStore.registeringWithGoogleInProgress(false);
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
      _registerStore.isValidFields(true);
    } else {
      _registerStore.isValidFields(false);
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

  /// [autoValidateConfirmPassword] Esse método é responsável por validar se o valor
  /// inserido no campo de confirmacao de senha está em um formato válido.
  /// e se o campo senha esta igual ao campo confirmação de senha
  /// Ele é usado pelo formulário para validação automática
  /// quando o usuário digita o valor.
  String? autoValidateConfirmPassword(String? confirmPasswordInput) {
    if (passwordRegex.hasMatch(confirmPasswordInput ?? '')) {
      if (confirmPasswordInput == passwordController.text) {
        return null;
      } else {
        return 'As senhas estão divergentes';
      }
    } else {
      return 'Senha deve ter no minimo 8 caracteres';
    }
  }
}
