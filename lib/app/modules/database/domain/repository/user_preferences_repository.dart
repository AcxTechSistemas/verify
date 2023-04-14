import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/database/domain/errors/user_preferences_error.dart';

abstract class UserPreferencesRepository {
  // User Preferences
  Future<Result<void, UserPreferencesError>> saveUserThemePreference({
    required ThemeMode themeMode,
  });
  Future<Result<void, UserPreferencesError>> updateUserThemePreference({
    required ThemeMode themeMode,
  });
  Future<Result<ThemeMode, UserPreferencesError>> readUserThemePreference();
  Future<Result<void, UserPreferencesError>> deleteUserThemePreference();
}
