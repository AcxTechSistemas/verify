import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/modules/config/presenter/shared/widgets/setup_field_widget.dart';
import 'package:verify/app/modules/config/presenter/sicoob_settings/controller/sicoob_settings_page_controller.dart';
import 'package:verify/app/modules/config/presenter/sicoob_settings/store/sicoob_settings_store.dart';
import 'package:verify/app/shared/widgets/custom_snack_bar.dart';

class SicoobSettingsPage extends StatefulWidget {
  const SicoobSettingsPage({super.key});

  @override
  State<SicoobSettingsPage> createState() => _SicoobSettingsPageState();
}

class _SicoobSettingsPageState extends State<SicoobSettingsPage> {
  final controller = Modular.get<SicoobSettingsPageController>();
  final store = Modular.get<SicoobSettingsStore>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sicoob',
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
                      'Chave Pix cadastrada no Sicoob',
                    ),
                    const CategoryWidget(
                      'Exclusivo para pessoa jurídica',
                    ),
                    const CategoryWidget(
                      'Cadastro no Portal Developers Sicoob',
                    ),
                    const CategoryWidget(
                      'Certificado válido emitido por CAs externas em conformidade com o padrão internacional x.509',
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'CONHEÇA O PORTAL DEVELOPERS SICOOB E CADASTRE-SE',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
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
                          title: 'ClientID',
                          onPressed: controller.clientIDController.clear,
                          controller: controller.clientIDController,
                          validator: controller.validateClientID,
                        ),
                        const SizedBox(height: 16),
                        SetupFieldWidget(
                          title: 'Senha do certificado',
                          onPressed:
                              controller.certificatePasswordController.clear,
                          controller: controller.certificatePasswordController,
                          validator: controller.validateCertificatePassword,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  InkWell(
                    onTap: controller.pickCertificate,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Observer(builder: (context) {
                                return Visibility(
                                  visible: store.certificateFileName.isEmpty,
                                  child: Text(
                                    'Enviar certificado',
                                    style: textTheme.bodyMedium,
                                  ),
                                );
                              }),
                              Observer(builder: (context) {
                                const title = 'Selecione um certificado';
                                final fileName = store.certificateFileName;
                                return Text(
                                  store.certificateFileName.isEmpty
                                      ? title
                                      : fileName,
                                  style: textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              }),
                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.attach_file),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('Cancelar'),
                  ),
                  const Spacer(),
                  Observer(builder: (context) {
                    return FilledButton(
                      onPressed:
                          store.isValidFields ? _validateCredentials : null,
                      child: const Text('Validar credenciais'),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _validateCredentials() async {
    controller.validateCredentials().then((errorMessage) {
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
