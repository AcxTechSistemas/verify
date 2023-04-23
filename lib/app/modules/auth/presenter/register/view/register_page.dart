import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/modules/auth/presenter/register/controller/register_controller.dart';
import 'package:verify/app/modules/auth/presenter/register/store/register_store.dart';
import 'package:verify/app/modules/auth/presenter/shared/widgets/auth_action_button.dart';
import 'package:verify/app/modules/auth/presenter/shared/widgets/auth_field_widget.dart';
import 'package:verify/app/modules/auth/presenter/shared/widgets/auth_header_widget.dart';
import 'package:verify/app/shared/widgets/custom_snack_bar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controller = Modular.get<RegisterController>();
  final store = Modular.get<RegisterStore>();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Semantics(
          label: 'Tela de Registro',
          child: SingleChildScrollView(
            child: SizedBox(
              height: constraints.maxHeight,
              child: Column(
                children: [
                  const AuthHeaderWidget(),
                  Flexible(
                    flex: 80,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 25, 40, 39),
                      child: Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: controller.formKey,
                        onChanged: controller.validateFields,
                        child: Column(
                          children: [
                            Semantics(
                              label: 'Campo de email',
                              child: AuthFieldWidget(
                                labelText: 'Email',
                                keyboardType: TextInputType.emailAddress,
                                validator: controller.autoValidateEmail,
                                controller: controller.emailController,
                                focusNode: controller.emailFocus,
                                onEditingComplete:
                                    controller.passwordFocus.requestFocus,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Semantics(
                              label: 'Campo de senha',
                              child: AuthFieldWidget(
                                labelText: 'Senha',
                                isSecret: true,
                                validator: controller.autoValidatePassword,
                                controller: controller.passwordController,
                                focusNode: controller.passwordFocus,
                                onEditingComplete: controller
                                    .confirmPasswordFocus.requestFocus,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Semantics(
                              label: 'Campo para confirmar a senha',
                              child: AuthFieldWidget(
                                labelText: 'Confirme a senha',
                                isSecret: true,
                                validator:
                                    controller.autoValidateConfirmPassword,
                                controller:
                                    controller.confirmPasswordController,
                                focusNode: controller.confirmPasswordFocus,
                                onEditingComplete:
                                    controller.confirmPasswordFocus.unfocus,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Observer(builder: (context) {
                                return Semantics(
                                  label: 'Botão para cadastrar',
                                  child: AuthActionButton(
                                    title: 'Cadastrar',
                                    enabled: store.registerButtonEnabled,
                                    isLoading: store.registeringWithEmail,
                                    onPressed: _registerWithEmail,
                                  ),
                                );
                              }),
                            ),
                            const Spacer(),
                            Semantics(
                              label: 'Botao para voltar ao login',
                              child: TextButton.icon(
                                onPressed: controller.goToLoginPage,
                                icon: const Icon(Icons.arrow_back),
                                label: const Text('Voltar ao login'),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<void> _registerWithEmail() async {
    await controller.registerWithEmail().then((errorMessage) {
      if (errorMessage != null) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar(
            message: errorMessage,
            snackBarType: SnackBarType.error,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar(
            message: 'Confirme seu email no link enviado',
            snackBarType: SnackBarType.info,
          ),
        );
      }
    });
  }
}
