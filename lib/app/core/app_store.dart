import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:verify/app/modules/database/domain/usecase/user_preferences_usecases/read_user_theme_mode_preference_usecase.dart';

part 'app_store.g.dart';

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  @observable
  bool loading = false;

  @observable
  var themeMode = Observable<ThemeMode>(ThemeMode.system);

  @observable
  var currentDestination = Observable<int>(0);

  @action
  void setPreferredTheme(ThemeMode theme) {
    themeMode.value = theme;
  }

  @action
  void setCurrentDestination(int destination) {
    currentDestination.value = destination;
  }

  Future<void> loadData() async {
    loading = true;
    final readUserThemePreference =
        Modular.get<ReadUserThemeModePreferencesUseCase>();
    final mode = await readUserThemePreference();
    final themeResult = mode.getOrNull();
    if (themeResult != null) {
      setPreferredTheme(themeResult);
    }
    loading = false;
  }

  @action
  void dispose() {
    themeMode.value = ThemeMode.system;
    currentDestination.value = 0;
    loading = false;
  }
}
