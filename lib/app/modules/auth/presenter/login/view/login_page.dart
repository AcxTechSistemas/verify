import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/modules/auth/presenter/login/controller/login_controller.dart';
import 'package:verify/app/modules/auth/presenter/login/store/login_store.dart';
import 'package:verify/app/modules/auth/presenter/shared/widgets/auth_action_button.dart';
import 'package:verify/app/modules/auth/presenter/shared/widgets/auth_field_widget.dart';
import 'package:verify/app/modules/auth/presenter/shared/widgets/auth_header_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:verify/app/modules/auth/presenter/shared/widgets/google_sign_in_button_widget.dart';
import 'package:verify/app/shared/widgets/custom_snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Modular.get<LoginController>();
  final store = Modular.get<LoginStore>();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Semantics(
            label: 'Tela de login',
            child: SingleChildScrollView(
              child: SizedBox(
                height: constraints.maxHeight,
                child: Column(
                  children: [
                    const AuthHeaderWidget(),
                    Flexible(
                      flex: 60,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 25, 40, 39),
                        child: Form(
                          autovalidateMode: AutovalidateMode.always,
                          key: controller.formKey,
                          onChanged: controller.validateFields,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
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
                                      validator:
                                          controller.autoValidatePassword,
                                      controller: controller.passwordController,
                                      focusNode: controller.passwordFocus,
                                      onEditingComplete:
                                          controller.passwordFocus.unfocus,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Semantics(
                                        label: 'Botão para recuperar a senha',
                                        child: TextButton(
                                          onPressed:
                                              controller.goToRecoverAccountPage,
                                          child:
                                              const Text('Esqueceu a senha?'),
                                        ),
                                      ),
                                      Semantics(
                                        label: 'Botão de login',
                                        child: Observer(
                                          builder: (context) {
                                            return AuthActionButton(
                                              title: 'Login',
                                              enabled: store.loginButtonEnabled,
                                              onPressed: _loginWithEmail,
                                              isLoading:
                                                  store.loggingInWithEmail,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Observer(
                                builder: (context) {
                                  return Semantics(
                                    label: 'Botão para entrar com o Google',
                                    child: GoogleSignInButton(
                                      onTap: _loginWithGoogle,
                                      isLoading: store.loggingInWithGoogle,
                                    ),
                                  );
                                },
                              ),
                              Semantics(
                                label: 'Botão de cadastro',
                                child: TextButton.icon(
                                  onPressed: controller.goToRegisterPage,
                                  icon: const Icon(
                                      Icons.app_registration_rounded),
                                  label: const Text('Cadastre-se'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _loginWithEmail() async {
    await controller.loginWithEmail().then((errorMessage) {
      if (errorMessage != null) {
        var snackBarType = SnackBarType.error;
        ScaffoldMessenger.of(context).clearSnackBars();
        if (errorMessage.contains('Confirme seu email no link enviado')) {
          snackBarType = SnackBarType.info;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar(
            message: errorMessage,
            snackBarType: snackBarType,
          ),
        );
      }
    });
  }

  Future<void> _loginWithGoogle() async {
    ScaffoldMessenger.of(context).clearSnackBars();
    await controller.loginWithGoogle().then((errorMessage) {
      if (errorMessage != null) {
        ScaffoldMessenger.of(context).clearSnackBars();
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
