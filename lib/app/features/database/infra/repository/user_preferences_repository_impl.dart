import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/features/database/domain/errors/user_preferences_error.dart';
import 'package:verify/app/features/database/domain/repository/user_preferences_repository.dart';
import 'package:verify/app/features/database/infra/datasource/user_preferences_datasource.dart';

class UserPreferencesRepositoryImpl implements UserPreferencesRepository {
  final UserPreferencesDataSource _userPreferencesDataSource;
  UserPreferencesRepositoryImpl(this._userPreferencesDataSource);
  @override
  Future<Result<void, UserPreferencesError>> deleteUserThemePreference() async {
    try {
      await _userPreferencesDataSource.deleteUserThemePreference();
      return const Success(Void);
    } catch (e) {
      return Failure(UserThemePreferenceError(
        message: 'Não foi possivel remover seu tema favorito. Tente novamente',
      ));
    }
  }

  @override
  Future<Result<ThemeMode, UserPreferencesError>>
      readUserThemePreference() async {
    try {
      final userThemeMode =
          await _userPreferencesDataSource.readUserThemePreference();
      return Success(userThemeMode);
    } catch (e) {
      return Failure(UserThemePreferenceError(
        message:
            'Não foi possivel recuperar seu tema favorito. Tente novamente',
      ));
    }
  }

  @override
  Future<Result<void, UserPreferencesError>> saveUserThemePreference({
    required ThemeMode themeMode,
  }) async {
    try {
      await _userPreferencesDataSource.saveUserThemePreference(
        themeMode: themeMode,
      );
      return const Success(Void);
    } catch (e) {
      return Failure(UserThemePreferenceError(
        message: 'Não foi possivel salvar seu tema favorito. Tente novamente',
      ));
    }
  }

  @override
  Future<Result<void, UserPreferencesError>> updateUserThemePreference({
    required ThemeMode themeMode,
  }) async {
    try {
      await _userPreferencesDataSource.updateUserThemePreference(
        themeMode: themeMode,
      );
      return const Success(Void);
    } catch (e) {
      return Failure(UserThemePreferenceError(
        message:
            'Não foi possivel atualizar seu tema favorito. Tente novamente',
      ));
    }
  }
}
