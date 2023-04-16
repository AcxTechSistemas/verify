import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/core/app_store.dart';
import 'package:verify/app/modules/auth/domain/usecase/logout_usecase.dart';
import 'package:verify/app/modules/database/domain/usecase/user_preferences_usecases/save_user_theme_mode_preference_usecase.dart';

class SettingsPageController {
  final LogoutUseCase _logoutUseCase;
  final AppStore _appStore;
  final SaveUserThemeModePreferencesUseCase
      _saveUserThemeModePreferencesUseCase;

  SettingsPageController(
    this._logoutUseCase,
    this._appStore,
    this._saveUserThemeModePreferencesUseCase,
  );

  void goToSicoobSettings() {
    Modular.to.pushReplacementNamed('./sicoob-settings');
  }

  Future<void> logout() async {
    await _logoutUseCase();
    Modular.to.pushReplacementNamed('/auth/login');
  }

  void changeTheme(ThemeMode? themeMode) async {
    _appStore.setPreferredTheme(themeMode!);
    await saveThemeLocalDatabase(themeMode);
  }

  Future<void> saveThemeLocalDatabase(ThemeMode themeMode) async {
    await _saveUserThemeModePreferencesUseCase(themeMode: themeMode);
  }
}
