import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/core/api_credentials_store.dart';
import 'package:verify/app/modules/auth/presenter/shared/widgets/auth_action_button.dart';
import 'package:verify/app/modules/config/bb_settings/controller/bb_settings_page_controller.dart';
import 'package:verify/app/modules/config/bb_settings/store/bb_settings_store.dart';
import 'package:verify/app/modules/config/shared/widgets/setup_field_widget.dart';
import 'package:verify/app/shared/widgets/custom_snack_bar.dart';

class BBSettingsPage extends StatefulWidget {
  const BBSettingsPage({super.key});

  @override
  State<BBSettingsPage> createState() => _BBSettingsPageState();
}

class _BBSettingsPageState extends State<BBSettingsPage> {
  final controller = Modular.get<BBSettingsPageController>();
  final store = Modular.get<BBSettingsStore>();
  final apiStore = Modular.get<ApiCredentialsStore>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Banco do Brasil',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: colorScheme.onInverseSurface,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Pré requisitos:',
                      style: textTheme.titleMedium,
                    ),
                    const CategoryWidget(
                      'Chave Pix cadastrada no Banco do Brasil',
                    ),
                    const CategoryWidget(
                      'Exclusivo para pessoa jurídica',
                    ),
                    const CategoryWidget(
                      'Cadastro no Portal Developers BB',
                    ),
                    TextButton(
                      onPressed: controller.goToBBDevelopersPortal,
                      child: const Text(
                        'CONHEÇA O PORTAL DEVELOPERS BB E CADASTRE-SE',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Observer(builder: (context) {
                if (apiStore.bbApiCredentialsEntity != null) {
                  return Column(
                    children: [
                      Image.asset(
                        'assets/images/bancoDoBrasilAccountCard.png',
                        scale: 1.7,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: AuthActionButton(
                          title: 'Remover credenciais',
                          color: colorScheme.error,
                          onPressed: _removeCredentials,
                          enabled: apiStore.bbApiCredentialsEntity != null,
                          isLoading:
                              store.isSavingInCloud || store.isSavingInLocal,
                        ),
                      ),
                    ],
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Configure sua conta:'),
                    const SizedBox(height: 16),
                    Form(
                      key: controller.formKey,
                      onChanged: () => controller.validateFields(),
                      child: Column(
                        children: [
                          SetupFieldWidget(
                            title: 'Application developer key',
                            controller: controller.appDevKeyController,
                            validator: controller.validateAppDevKey,
                            focusNode: controller.appDevKeyFocus,
                            onPressed: controller.appDevKeyController.clear,
                            onEditingComplete:
                                controller.basicKeyFocus.requestFocus,
                          ),
                          const SizedBox(height: 16),
                          SetupFieldWidget(
                            title: 'Basic key',
                            onPressed: controller.basicKeyController.clear,
                            controller: controller.basicKeyController,
                            validator: controller.validateBasicKey,
                            focusNode: controller.basicKeyFocus,
                            onEditingComplete: controller.basicKeyFocus.unfocus,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: controller.popPage,
                            child: const Text('Cancelar'),
                          ),
                          const Spacer(),
                          AuthActionButton(
                            title: 'Validar credenciais',
                            onPressed: _validateCredentials,
                            enabled: store.isValidFields,
                            isLoading: store.isValidatingCredentials ||
                                store.isSavingInCloud ||
                                store.isSavingInLocal,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  _validateCredentials() async {
    controller.validateCredentials().then((errorMessage) async {
      if (errorMessage != null) {
        _showSnackBar(
          errorMessage: errorMessage,
          type: SnackBarType.error,
        );
      } else {
        _showSnackBar(
          errorMessage: 'Credenciais validadas com sucesso!',
          type: SnackBarType.success,
        );
      }
    });
  }

  _removeCredentials() async {
    controller.removeCredentials().then((errorMessage) async {
      if (errorMessage != null) {
        _showSnackBar(
          errorMessage: errorMessage,
          type: SnackBarType.error,
        );
      } else {
        _showSnackBar(
          errorMessage: 'Credenciais removidas com sucesso!',
          type: SnackBarType.success,
        );
      }
    });
  }

  _showSnackBar({
    required String errorMessage,
    required SnackBarType type,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBar(
        message: errorMessage,
        snackBarType: type,
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final String text;
  const CategoryWidget(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Row(
        children: [
          CircleAvatar(
            maxRadius: 2,
            backgroundColor: colorScheme.primary,
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: screenSize.width * 0.8,
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
