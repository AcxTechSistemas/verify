import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/core/api_credentials_store.dart';
import 'package:verify/app/core/app_store.dart';
import 'package:verify/app/core/auth_store.dart';
import 'package:verify/app/modules/auth/domain/usecase/logout_usecase.dart';
import 'package:verify/app/modules/database/domain/usecase/bb_api_credentials_usecases/remove_bb_api_credentials_usecase.dart';
import 'package:verify/app/modules/database/domain/usecase/sicoob_api_credentials_usecases/remove_sicoob_api_credentials_usecase.dart';
import 'package:verify/app/modules/database/domain/usecase/user_preferences_usecases/remove_user_theme_mode_preference_usecase.dart';
import 'package:verify/app/modules/database/domain/usecase/user_preferences_usecases/save_user_theme_mode_preference_usecase.dart';
import 'package:verify/app/modules/database/utils/database_enums.dart';

class SettingsPageController {
  final RemoveBBApiCredentialsUseCase _removeBBApiCredentialsUseCase;
  final RemoveSicoobApiCredentialsUseCase _removeSicoobApiCredentialsUseCase;
  final RemoveUserThemeModePreferencesUseCase
      _removeUserThemeModePreferencesUseCase;

  SettingsPageController(
    this._removeBBApiCredentialsUseCase,
    this._removeSicoobApiCredentialsUseCase,
    this._removeUserThemeModePreferencesUseCase,
  );
  void goToSicoobSettings() {
    Modular.to.pushReplacementNamed('./sicoob-settings');
  }

  void goToBBSettings() {
    Modular.to.pushReplacementNamed('./bb-settings');
  }

  Future<void> logout() async {
    final loggout = Modular.get<LogoutUseCase>();
    await loggout().then((loggedOut) async {
      if (loggedOut.isSuccess()) {
        await _eraseAll();
      }
    });
    Modular.to.pushReplacementNamed('/auth/login');
  }

  Future<void> _eraseAll() async {
    await _removeBBApiCredentialsUseCase(
      id: '',
      database: Database.local,
    );
    await _removeSicoobApiCredentialsUseCase(
      id: '',
      database: Database.local,
    );
    await _removeUserThemeModePreferencesUseCase();
    final appStore = Modular.get<AppStore>();
    final authStore = Modular.get<AuthStore>();
    final apiStore = Modular.get<ApiCredentialsStore>();
    appStore.dispose();
    authStore.dispose();
    apiStore.dispose();
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
