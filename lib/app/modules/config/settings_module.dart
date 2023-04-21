import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/modules/config/presenter/bb_settings/view/bb_settings_page.dart';
import 'package:verify/app/modules/config/presenter/settings/controller/settings_page_controller.dart';
import 'package:verify/app/modules/config/presenter/settings/view/settings_page.dart';
import 'package:verify/app/modules/config/presenter/sicoob_settings/store/sicoob_settings_store.dart';
import 'package:verify/app/modules/config/presenter/sicoob_settings/view/sicoob_settings_page.dart';

import 'presenter/bb_settings/controller/bb_settings_page_controller.dart';
import 'presenter/bb_settings/store/bb_settings_store.dart';
import 'presenter/sicoob_settings/controller/sicoob_settings_page_controller.dart';

class SettingsModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        AutoBind.singleton<SettingsPageController>(SettingsPageController.new),
        AutoBind.singleton<SicoobSettingsPageController>(
          SicoobSettingsPageController.new,
        ),
        AutoBind.singleton<SicoobSettingsStore>(
          SicoobSettingsStore.new,
        ),
        AutoBind.singleton<BBSettingsPageController>(
          BBSettingsPageController.new,
        ),
        AutoBind.singleton<BBSettingsStore>(
          BBSettingsStore.new,
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, _) => const SettingsPage(),
          transition: TransitionType.fadeIn,
          duration: const Duration(milliseconds: 300),
        ),
        ChildRoute(
          '/sicoob-settings',
          child: (context, _) => const SicoobSettingsPage(),
        ),
        ChildRoute(
          '/bb-settings',
          child: (context, _) => const BBSettingsPage(),
        ),
      ];
}
