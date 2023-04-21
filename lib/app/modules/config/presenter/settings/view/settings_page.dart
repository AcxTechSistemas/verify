import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/core/api_credentials_store.dart';
import 'package:verify/app/core/app_store.dart';
import 'package:verify/app/core/auth_store.dart';
import 'package:verify/app/modules/config/presenter/settings/controller/settings_page_controller.dart';
import 'package:verify/app/modules/config/presenter/settings/view/widgets/accounts_list_tile_widget.dart';
import 'package:verify/app/shared/widgets/custom_navigation_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final appStore = Modular.get<AppStore>();
  final authStore = Modular.get<AuthStore>();
  final apiStore = Modular.get<ApiCredentialsStore>();
  final apiCredentialsStore = Modular.get<ApiCredentialsStore>();
  final controller = Modular.get<SettingsPageController>();
  @override
  void initState() {
    apiStore.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Ajustes'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorScheme.onInverseSurface,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: screenSize.width * 0.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            authStore.userName,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: textTheme.headlineSmall!.copyWith(
                              color: colorScheme.primary,
                            ),
                          ),
                          Text(
                            authStore.loggedUser?.email ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: textTheme.titleSmall!.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: controller.logout,
                      icon: const Icon(Icons.exit_to_app),
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
                  const Text('Tema'),
                  Observer(builder: (context) {
                    return RadioListTile<ThemeMode>(
                      title: Row(children: [
                        const Text('Sistema'),
                        const Spacer(),
                        Icon(
                          Icons.devices,
                          color: colorScheme.primary,
                        ),
                      ]),
                      value: ThemeMode.system,
                      groupValue: appStore.themeMode.value,
                      onChanged: controller.changeTheme,
                    );
                  }),
                  Observer(builder: (context) {
                    return RadioListTile<ThemeMode>(
                      title: Row(children: [
                        const Text('Claro'),
                        const Spacer(),
                        Icon(
                          Icons.sunny,
                          color: colorScheme.primary,
                        ),
                      ]),
                      value: ThemeMode.light,
                      groupValue: appStore.themeMode.value,
                      onChanged: controller.changeTheme,
                    );
                  }),
                  Observer(builder: (context) {
                    return RadioListTile<ThemeMode>(
                      title: Row(children: [
                        const Text('Escuro'),
                        const Spacer(),
                        Icon(
                          Icons.nights_stay,
                          color: colorScheme.primary,
                        ),
                      ]),
                      value: ThemeMode.dark,
                      groupValue: appStore.themeMode.value,
                      onChanged: controller.changeTheme,
                    );
                  }),
                  Divider(
                    color: colorScheme.primary,
                  ),
                  const SizedBox(height: 24),
                  const Text('Suas Contas'),
                  const SizedBox(height: 16),
                  AccountListTile(
                    bank: Bank.sicoob,
                    hasCredentials:
                        apiCredentialsStore.sicoobApiCredentialsEntity != null,
                    onTap: controller.goToSicoobSettings,
                  ),
                  const SizedBox(height: 16),
                  AccountListTile(
                    bank: Bank.bancoDoBrasil,
                    hasCredentials:
                        apiCredentialsStore.bbApiCredentialsEntity != null,
                    onTap: controller.goToBBSettings,
                  ),
                  const SizedBox(height: 32),
                  _DevelopedWith(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}

class _DevelopedWith extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final textStyle = textTheme.titleSmall!.copyWith(
      color: colorScheme.outline,
    );

    final controller = Modular.get<SettingsPageController>();

    return Column(
      children: [
        Text(
          'Developed with',
          style: textStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(),
            Text(
              'Flutter',
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'By AcxTech Sistemas',
          style: textStyle,
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () async => await controller.goToInstagram(),
              icon: const Icon(CommunityMaterialIcons.instagram),
            ),
            IconButton(
              onPressed: () async => await controller.goToWhatsapp(),
              icon: const Icon(CommunityMaterialIcons.whatsapp),
            ),
            IconButton(
              onPressed: () async => await controller.goToGithub(),
              icon: const Icon(CommunityMaterialIcons.github),
            ),
            IconButton(
              onPressed: () async => await controller.goToLinkedin(),
              icon: const Icon(CommunityMaterialIcons.linkedin),
            ),
          ],
        ),
      ],
    );
  }
}
