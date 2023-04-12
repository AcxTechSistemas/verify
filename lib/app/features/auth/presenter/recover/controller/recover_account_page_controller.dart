import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/features/auth/domain/usecase/recover_account_usecase.dart';
import 'package:verify/app/features/auth/presenter/recover/store/recover_account_store.dart';
import 'package:verify/app/features/auth/utils/email_regex.dart';

class RecoverAccountPageController {
  final RecoverAccountUseCase _recoverAccountUseCase;
  final RecoverAccountPageStore _recoverAccountPageStore;
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final emailFocus = FocusNode();

  RecoverAccountPageController(
    this._recoverAccountUseCase,
    this._recoverAccountPageStore,
  );

  void backToLoginPage() {
    dispose();
    Modular.to.pushReplacementNamed('./login');
  }

  String? autoValidateEmail(String? emailInput) {
    if (emailRegex.hasMatch(emailInput ?? '')) {
      return null;
    } else {
      return 'Digite um email válido';
    }
  }

  void validateField() {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      _recoverAccountPageStore.validateField(true);
    } else {
      _recoverAccountPageStore.validateField(false);
    }
  }

  Future<String?> sendRecoverInstructions() async {
    emailFocus.unfocus();
    _recoverAccountPageStore.recoveringWithEmailInProgress(true);
    final result = await _recoverAccountUseCase(email: emailController.text);

    return result.fold(
      (success) {
        _recoverAccountPageStore.recoveringWithEmailInProgress(false);
        return null;
      },
      (failure) {
        _recoverAccountPageStore.recoveringWithEmailInProgress(false);
        return failure.message;
      },
    );
  }

  void dispose() {
    _recoverAccountPageStore.recoveringWithEmailInProgress(false);
    _recoverAccountPageStore.validateField(false);
  }
}
