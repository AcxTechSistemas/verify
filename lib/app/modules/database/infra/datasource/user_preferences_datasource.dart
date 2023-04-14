import 'package:flutter/material.dart';

abstract class UserPreferencesDataSource {
  // Theme
  Future<void> saveUserThemePreference({
    required ThemeMode themeMode,
  });
  Future<void> updateUserThemePreference({
    required ThemeMode themeMode,
  });
  Future<ThemeMode> readUserThemePreference();
  Future<void> deleteUserThemePreference();
}
