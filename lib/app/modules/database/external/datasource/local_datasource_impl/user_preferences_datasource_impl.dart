import 'package:flutter/material.dart';
import 'package:verify/app/shared/error_registrator/register_log.dart';
import 'package:verify/app/shared/error_registrator/send_logs_to_web.dart';
import 'package:verify/app/modules/database/domain/errors/user_preferences_error.dart';
import 'package:verify/app/modules/database/infra/datasource/user_preferences_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/app/modules/database/utils/database_enums.dart';

class UserPreferencesLocalDataSourceImpl implements UserPreferencesDataSource {
  final SharedPreferences _sharedPreferences;
  final RegisterLog _registerLog;
  final SendLogsToWeb _sendLogsToWeb;

  UserPreferencesLocalDataSourceImpl(
    this._sharedPreferences,
    this._registerLog,
    this._sendLogsToWeb,
  );

  @override
  Future<void> saveUserThemePreference({
    required ThemeMode themeMode,
  }) async {
    try {
      final saved = await _sharedPreferences.setString(
        DocumentName.userThemePreference.name,
        themeMode.name,
      );
      if (saved != true) {
        const logError =
            'SharedPreferencesError: Error on Save saveUserThemePreference';
        _sendLogsToWeb(logError);
        _registerLog(logError);
        throw ErrorSavingUserThemePreference(
          message:
              'Ocorreu um erro ao salvar as preferencias de tema, tente novamente',
        );
      }
    } catch (e) {
      _registerLog(e);
      _sendLogsToWeb(e);
      throw ErrorSavingUserThemePreference(
        message:
            'Ocorreu um erro ao salvar as preferencias de tema, tente novamente',
      );
    }
  }

  @override
  Future<ThemeMode> readUserThemePreference() async {
    late ThemeMode themeMode;
    try {
      final theme = _sharedPreferences.getString(
        DocumentName.userThemePreference.name,
      );
      switch (theme) {
        case 'dark':
          themeMode = ThemeMode.dark;
          break;
        case 'light':
          themeMode = ThemeMode.light;
          break;
        case 'system':
          themeMode = ThemeMode.system;
          break;
        default:
          themeMode = ThemeMode.system;
      }
      return themeMode;
    } catch (e) {
      _registerLog(e);
      _sendLogsToWeb(e);
      throw ErrorReadUserThemePreference(
        message:
            'Ocorreu um erro ao recuperar as preferencias de tema, tente novamente',
      );
    }
  }

  @override
  Future<void> updateUserThemePreference({
    required ThemeMode themeMode,
  }) async {
    try {
      final theme = _sharedPreferences.getString(
        DocumentName.userThemePreference.name,
      );
      if (theme != null) {
        final saved = await _sharedPreferences.setString(
          DocumentName.userThemePreference.name,
          themeMode.name,
        );
        if (saved != true) {
          const logError =
              'SharedPreferencesError: Error on Update BBApiCredentials';
          _sendLogsToWeb(logError);
          _registerLog(logError);
          throw ErrorUpdateUserThemePreference(
            message:
                'Ocorreu um erro ao atualizar as preferencias de tema, tente novamente',
          );
        }
      } else {
        const logError =
            'SharedPreferencesError: Error on Update UserThemePreference, UserThemePreference not found';
        _sendLogsToWeb(logError);
        _registerLog(logError);
        throw ErrorUpdateUserThemePreference(
          message:
              'Não foi possível atualizar suas preferencias de tema, tente novamente',
        );
      }
    } on ErrorUpdateUserThemePreference {
      rethrow;
    } catch (e) {
      _registerLog(e);
      _sendLogsToWeb(e);
      throw ErrorUpdateUserThemePreference(
        message:
            'Ocorreu um erro ao atualizar as preferencias de tema, tente novamente',
      );
    }
  }

  @override
  Future<void> deleteUserThemePreference() async {
    try {
      final removed = await _sharedPreferences.remove(
        DocumentName.userThemePreference.name,
      );
      if (removed != true) {
        const logError =
            'SharedPreferencesError: Error on remove UserThemePreference';
        _sendLogsToWeb(logError);
        _registerLog(logError);
        throw ErrorDeletingUserThemePreference(
          message:
              'Ocorreu um erro ao remover as preferencias de tema, tente novamente',
        );
      }
    } catch (e) {
      _registerLog(e);
      _sendLogsToWeb(e);
      throw ErrorDeletingUserThemePreference(
        message:
            'Ocorreu um erro ao remover as preferencias de tema, tente novamente',
      );
    }
  }
}
