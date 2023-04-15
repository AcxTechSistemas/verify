import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/modules/database/domain/errors/user_preferences_error.dart';
import 'package:verify/app/modules/database/domain/repository/user_preferences_repository.dart';
import 'package:verify/app/modules/database/infra/datasource/user_preferences_datasource.dart';

class UserPreferencesRepositoryImpl implements UserPreferencesRepository {
  final UserPreferencesDataSource _userPreferencesDataSource;

  UserPreferencesRepositoryImpl(this._userPreferencesDataSource);

  @override
  Future<Result<void, UserPreferencesError>> saveUserThemePreference({
    required ThemeMode themeMode,
  }) async {
    try {
      await _userPreferencesDataSource.saveUserThemePreference(
        themeMode: themeMode,
      );
      return const Success(Void);
    } on ErrorSavingUserThemePreference catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(ErrorSavingUserThemePreference(
        message:
            'Não foi possivel salvar sua preferencia de tema. Tente novamente',
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
    } on ErrorReadUserThemePreference catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(ErrorReadUserThemePreference(
        message:
            'Não foi possivel recuperar sua preferencia de tema. Tente novamente',
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
    } on ErrorUpdateUserThemePreference catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(ErrorUpdateUserThemePreference(
        message:
            'Não foi possivel atualizar sua preferencia de tema. Tente novamente',
      ));
    }
  }

  @override
  Future<Result<void, UserPreferencesError>> deleteUserThemePreference() async {
    try {
      await _userPreferencesDataSource.deleteUserThemePreference();
      return const Success(Void);
    } on ErrorDeletingUserThemePreference catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(ErrorDeletingUserThemePreference(
        message:
            'Não foi possivel remover sua preferencia de tema. Tente novamente',
      ));
    }
  }
}
