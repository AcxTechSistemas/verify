import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';
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

  Future<void> goToInstagram() async {
    final instagramUrl = Uri.parse(
      'instagram://user?username=alefe.dev',
    );
    await launchUrl(instagramUrl);
  }

  Future<void> goToWhatsapp() async {
    final whatsappUrl = Uri.parse(
      'whatsapp://send?phone=5562993149401&text=Bem%20vindo%20a%20AcxTech%20Sistemas.%20Vi%20que%20vc%20veio%20pelo%20nosso%20app:%20Verify!%20Em%20que%20podemos%20ajudar%3F',
    );
    await launchUrl(whatsappUrl);
  }

  Future<void> goToGithub() async {
    final githubUrl = Uri.parse(
      'https://github.com/AcxTechSistemas',
    );
    await launchUrl(githubUrl);
  }

  Future<void> goToLinkedin() async {
    final linkedinUrl = Uri.parse(
      'https://www.linkedin.com/in/alefealvessilva',
    );
    await launchUrl(linkedinUrl);
  }

  void goToSicoobSettings() {
    Modular.to.pushNamed('./sicoob-settings');
  }

  void goToBBSettings() {
    Modular.to.pushNamed('./bb-settings');
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
