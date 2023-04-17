import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:verify/app/modules/database/domain/usecase/user_preferences_usecases/read_user_theme_mode_preference_usecase.dart';

part 'app_store.g.dart';

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  @observable
  var themeMode = Observable<ThemeMode>(ThemeMode.system);

  @observable
  var currentDestination = Observable<int>(0);

  @action
  setPreferredTheme(ThemeMode theme) {
    themeMode.value = theme;
  }

  @action
  setCurrentDestination(int destination) {
    currentDestination.value = destination;
  }

  Future<void> loadData() async {
    final readUserThemePreference =
        Modular.get<ReadUserThemeModePreferencesUseCase>();
    final mode = await readUserThemePreference();
    final themeResult = mode.getOrNull();
    if (themeResult != null) {
      setPreferredTheme(themeResult);
    }
  }
}
