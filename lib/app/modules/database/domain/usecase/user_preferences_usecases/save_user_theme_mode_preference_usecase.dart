import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/database/domain/errors/user_preferences_error.dart';
import 'package:verify/app/modules/database/domain/repository/user_preferences_repository.dart';

abstract class SaveUserThemeModePreferencesUseCase {
  Future<Result<void, UserPreferencesError>> call({
    required ThemeMode themeMode,
  });
}

class SaveUserThemeModePreferencesUseCaseImpl
    implements SaveUserThemeModePreferencesUseCase {
  final UserPreferencesRepository _userPreferencesRepository;

  SaveUserThemeModePreferencesUseCaseImpl(this._userPreferencesRepository);
  @override
  Future<Result<void, UserPreferencesError>> call({
    required ThemeMode themeMode,
  }) async {
    return await _userPreferencesRepository.saveUserThemePreference(
      themeMode: themeMode,
    );
  }
}
