import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/modules/config/presenter/settings/controller/settings_page_controller.dart';
import 'package:verify/app/modules/config/presenter/settings/view/settings_page.dart';
import 'package:verify/app/modules/config/presenter/sicoob_settings/store/sicoob_settings_store.dart';
import 'package:verify/app/modules/config/presenter/sicoob_settings/view/sicoob_settings_page.dart';

import 'presenter/sicoob_settings/controller/sicoob_settings_page_controller.dart';

class ConfigModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        AutoBind.singleton<SettingsPageController>(SettingsPageController.new),
        AutoBind.singleton<SicoobSettingsPageController>(
          SicoobSettingsPageController.new,
        ),
        AutoBind.singleton<SicoobSettingsStore>(
          SicoobSettingsStore.new,
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, _) => const SettingsPage()),
        ChildRoute(
          '/sicoob-settings',
          child: (context, _) => const SicoobSettingsPage(),
        ),
      ];
}
