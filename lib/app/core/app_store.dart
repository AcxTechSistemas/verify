import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:verify/app/modules/database/domain/usecase/user_preferences_usecases/read_user_theme_mode_preference_usecase.dart';

part 'app_store.g.dart';

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  final ReadUserThemeModePreferencesUseCase
      _readUserThemeModePreferencesUseCase;

  late ThemeMode mode;
  @observable
  var themeMode = Observable<ThemeMode>(ThemeMode.system);

  @observable
  var currentDestination = Observable<int>(0);

  AppStoreBase(this._readUserThemeModePreferencesUseCase);

  @action
  setPreferredTheme(ThemeMode theme) {
    themeMode.value = theme;
  }

  @action
  setCurrentDestination(int destination) {
    currentDestination.value = destination;
  }

  Future<void> loadData() async {
    final mode = await _readUserThemeModePreferencesUseCase();
    final themeResult = mode.getOrNull();
    if (themeResult != null) {
      setPreferredTheme(themeResult);
    }
  }
}
