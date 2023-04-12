import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/features/database/local_database/domain/errors/user_preferences_error.dart';
import 'package:verify/app/features/database/local_database/domain/repository/local_database_repository.dart';

abstract class SaveUserThemeModePreferencesUseCase {
  Future<Result<void, UserPreferencesError>> call({
    required ThemeMode themeMode,
  });
}

class SaveUserThemeModePreferencesUseCaseImpl
    implements SaveUserThemeModePreferencesUseCase {
  final LocalDataBaseRepository _localDataBaseRepository;

  SaveUserThemeModePreferencesUseCaseImpl(this._localDataBaseRepository);
  @override
  Future<Result<void, UserPreferencesError>> call({
    required ThemeMode themeMode,
  }) async {
    return await _localDataBaseRepository.saveUserThemePreference(
      themeMode: themeMode,
    );
  }
}
