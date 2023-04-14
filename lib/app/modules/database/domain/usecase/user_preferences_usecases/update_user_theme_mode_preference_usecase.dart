import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/database/domain/errors/user_preferences_error.dart';
import 'package:verify/app/modules/database/domain/repository/user_preferences_repository.dart';

abstract class UpdateUserThemeModePreferencesUseCase {
  Future<Result<void, UserPreferencesError>> call({
    required ThemeMode themeMode,
  });
}

class UpdateUserThemeModePreferencesUseCaseImpl
    implements UpdateUserThemeModePreferencesUseCase {
  final UserPreferencesRepository _userPreferencesRepository;

  UpdateUserThemeModePreferencesUseCaseImpl(this._userPreferencesRepository);
  @override
  Future<Result<void, UserPreferencesError>> call({
    required ThemeMode themeMode,
  }) async {
    return await _userPreferencesRepository.updateUserThemePreference(
      themeMode: themeMode,
    );
  }
}
