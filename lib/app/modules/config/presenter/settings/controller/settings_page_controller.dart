import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/core/app_store.dart';
import 'package:verify/app/modules/auth/domain/usecase/logout_usecase.dart';
import 'package:verify/app/modules/database/domain/usecase/user_preferences_usecases/save_user_theme_mode_preference_usecase.dart';

class SettingsPageController {
  void goToSicoobSettings() {
    Modular.to.pushReplacementNamed('./sicoob-settings');
  }

  Future<void> logout() async {
    final loggout = Modular.get<LogoutUseCase>();
    await loggout();
    Modular.to.pushReplacementNamed('/auth/login');
  }

  void changeTheme(ThemeMode? themeMode) async {
    final appStore = Modular.get<AppStore>();
    appStore.setPreferredTheme(themeMode!);
    await saveThemeLocalDatabase(themeMode);
  }

  Future<void> saveThemeLocalDatabase(ThemeMode themeMode) async {
    final saveUserThemeMode =
        Modular.get<SaveUserThemeModePreferencesUseCase>();
    await saveUserThemeMode(themeMode: themeMode);
  }
}
