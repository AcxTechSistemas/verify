import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/database/domain/errors/user_preferences_error.dart';
import 'package:verify/app/modules/database/domain/repository/user_preferences_repository.dart';

abstract class ReadUserThemeModePreferencesUseCase {
  Future<Result<ThemeMode, UserPreferencesError>> call();
}

class ReadUserThemeModePreferencesUseCaseImpl
    implements ReadUserThemeModePreferencesUseCase {
  final UserPreferencesRepository _userPreferencesRepository;

  ReadUserThemeModePreferencesUseCaseImpl(this._userPreferencesRepository);
  @override
  Future<Result<ThemeMode, UserPreferencesError>> call() async {
    return await _userPreferencesRepository.readUserThemePreference();
  }
}
