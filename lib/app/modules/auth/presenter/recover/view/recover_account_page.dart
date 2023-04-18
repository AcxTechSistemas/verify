import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/modules/auth/presenter/recover/controller/recover_account_page_controller.dart';
import 'package:verify/app/modules/auth/presenter/recover/store/recover_account_store.dart';
import 'package:verify/app/modules/auth/presenter/shared/widgets/auth_action_button.dart';
import 'package:verify/app/modules/auth/presenter/shared/widgets/auth_field_widget.dart';
import 'package:verify/app/shared/widgets/custom_snack_bar.dart';

class RecoverAccountPage extends StatefulWidget {
  const RecoverAccountPage({super.key});

  @override
  State<RecoverAccountPage> createState() => _RecoverAccountPageState();
}

class _RecoverAccountPageState extends State<RecoverAccountPage> {
  final controller = Modular.get<RecoverAccountPageController>();
  final store = Modular.get<RecoverAccountPageStore>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        leading: IconButton(
          onPressed: controller.backToLoginPage,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Recupere sua conta',
                style: textTheme.headlineSmall,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 16),
              Text(
                'Digite o e-mail associado à sua conta e enviaremos um e-mail com instruções para redefinir sua senha',
                style: textTheme.titleSmall!
                    .copyWith(color: colorScheme.onSurfaceVariant),
                textAlign: TextAlign.start,
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Form(
                      key: controller.formKey,
                      onChanged: controller.validateField,
                      child: AuthFieldWidget(
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: controller.autoValidateEmail,
                        controller: controller.emailController,
                        focusNode: controller.emailFocus,
                        onEditingComplete: controller.emailFocus.unfocus,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Observer(
                      builder: (context) {
                        return AuthActionButton(
                          title: 'Enviar instruções',
                          enabled: store.enableRecoverButton,
                          onPressed: _sendRecoverInstructions,
                          isLoading: store.recovertingWithEmail,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _sendRecoverInstructions() {
    ScaffoldMessenger.of(context).clearSnackBars();
    controller.sendRecoverInstructions().then((errorMessage) {
      if (errorMessage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar(
            message: 'Enviamos as instruções para seu email',
            snackBarType: SnackBarType.success,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar(
            message: errorMessage,
            snackBarType: SnackBarType.error,
          ),
        );
      }
    });
  }
}
