import 'package:flutter/material.dart';
import 'package:verify/app/shared/error_registrator/register_log.dart';
import 'package:verify/app/shared/error_registrator/send_logs_to_web.dart';
import 'package:verify/app/modules/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/modules/database/domain/errors/user_preferences_error.dart';
import 'package:verify/app/modules/database/infra/datasource/local_api_credentials_datasource.dart';
import 'package:verify/app/modules/database/infra/datasource/user_preferences_datasource.dart';
import 'package:verify/app/modules/database/infra/models/sicoob_api_credentials_model.dart';
import 'package:verify/app/modules/database/infra/models/bb_api_credentials_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/app/modules/database/utils/database_enums.dart';

class SharedPreferencesLocalDataSourceImpl
    implements LocalApiCredentialsDataSource, UserPreferencesDataSource {
  final SharedPreferences _sharedPreferences;
  final RegisterLog _registerLog;
  final SendLogsToWeb _sendLogsToWeb;

  SharedPreferencesLocalDataSourceImpl(
    this._sharedPreferences,
    this._registerLog,
    this._sendLogsToWeb,
  );

  @override
  Future<void> saveBBApiCredentials({
    required String id,
    required String applicationDeveloperKey,
    required String basicKey,
    required bool isFavorite,
  }) async {
    try {
      final bbCredentials = BBApiCredentialsModel(
        applicationDeveloperKey: applicationDeveloperKey,
        basicKey: basicKey,
        isFavorite: isFavorite,
      );
      final saved = await _sharedPreferences.setString(
        DocumentName.bbApiCredential.name,
        bbCredentials.toJson(),
      );
      if (saved != true) {
        const logError =
            'SharedPreferencesError: Error on Save BBApiCredentials';
        _sendLogsToWeb(logError);
        _registerLog(logError);
        throw ErrorSavingApiCredentials(
          message: 'Ocorreu um erro ao salvar as credenciais, tente novamente',
        );
      }
    } catch (e) {
      _registerLog(e);
      _sendLogsToWeb(e);
      throw ErrorSavingApiCredentials(
        message: 'Ocorreu um erro ao salvar as credenciais, tente novamente',
      );
    }
  }

  @override
  Future<BBApiCredentialsModel?> readBBApiCredentials({
    required String id,
  }) async {
    try {
      final bbCredentialsJson = _sharedPreferences.getString(
        DocumentName.bbApiCredential.name,
      );
      if (bbCredentialsJson != null) {
        final bbCredentials = BBApiCredentialsModel.fromJson(bbCredentialsJson);
        return bbCredentials;
      } else {
        return null;
      }
    } catch (e) {
      _registerLog(e);
      _sendLogsToWeb(e);
      throw ErrorReadingApiCredentials(
        message: 'Não foi possivel recuperar suas credenciais, tente novamente',
      );
    }
  }

  @override
  Future<void> updateBBApiCredentials({
    required String id,
    required String applicationDeveloperKey,
    required String basicKey,
    required bool isFavorite,
  }) async {
    try {
      final bbCredentialsJson = _sharedPreferences.getString(
        DocumentName.bbApiCredential.name,
      );
      if (bbCredentialsJson != null) {
        final bbCredentials = BBApiCredentialsModel.fromJson(bbCredentialsJson);
        final updatedBbCredentials = bbCredentials.copyWith(
          applicationDeveloperKey: applicationDeveloperKey,
          basicKey: basicKey,
          isFavorite: isFavorite,
        );
        final saved = await _sharedPreferences.setString(
          DocumentName.bbApiCredential.name,
          updatedBbCredentials.toJson(),
        );
        if (saved != true) {
          const logError =
              'SharedPreferencesError: Error on Update BBApiCredentials';
          _sendLogsToWeb(logError);
          _registerLog(logError);
          throw ErrorSavingApiCredentials(
            message:
                'Ocorreu um erro ao atualizar as credenciais, tente novamente',
          );
        }
      } else {
        const logError =
            'SharedPreferencesError: Error on Update BBApiCredentials, BBApiCredentials not found';
        _sendLogsToWeb(logError);
        _registerLog(logError);
        throw ErrorReadingApiCredentials(
          message:
              'Não foi possível atualizar suas credenciais, tente novamente',
        );
      }
    } on ErrorReadingApiCredentials {
      rethrow;
    } catch (e) {
      _registerLog(e);
      _sendLogsToWeb(e);
      throw ErrorUpdateApiCredentials(
        message: 'Ocorreu um erro ao atualizar as credenciais, tente novamente',
      );
    }
  }

  @override
  Future<void> deleteBBApiCredentials({required String id}) async {
    try {
      final removed = await _sharedPreferences.remove(
        DocumentName.bbApiCredential.name,
      );
      if (removed != true) {
        const logError =
            'SharedPreferencesError: Error on remove BBApiCredentials';
        _sendLogsToWeb(logError);
        _registerLog(logError);
        throw ErrorRemovingApiCredentials(
          message: 'Ocorreu um erro ao remover as credenciais, tente novamente',
        );
      }
    } catch (e) {
      _registerLog(e);
      _sendLogsToWeb(e);
      throw ErrorRemovingApiCredentials(
        message: 'Ocorreu um erro ao remover as credenciais, tente novamente',
      );
    }
  }

  @override
  Future<void> saveSicoobApiCredentials({
    required String id,
    required String clientID,
    required String certificatePassword,
    required String certificateBase64String,
    required bool isFavorite,
  }) async {
    try {
      final sicoobCredentials = SicoobApiCredentialsModel(
        clientID: clientID,
        certificateBase64String: certificateBase64String,
        certificatePassword: certificatePassword,
        isFavorite: isFavorite,
      );
      final saved = await _sharedPreferences.setString(
        DocumentName.sicoobApiCredential.name,
        sicoobCredentials.toJson(),
      );
      if (saved != true) {
        const logError =
            'SharedPreferencesError: Error on Save BBApiCredentials';
        _sendLogsToWeb(logError);
        _registerLog(logError);
        throw ErrorSavingApiCredentials(
          message: 'Ocorreu um erro ao salvar as credenciais, tente novamente',
        );
      }
    } catch (e) {
      _registerLog(e);
      _sendLogsToWeb(e);
      throw ErrorSavingApiCredentials(
        message: 'Ocorreu um erro ao salvar as credenciais, tente novamente',
      );
    }
  }

  @override
  Future<SicoobApiCredentialsModel?> readSicoobApiCredentials({
    required String id,
  }) async {
    try {
      final sicoobCredentialsJson = _sharedPreferences.getString(
        DocumentName.sicoobApiCredential.name,
      );
      if (sicoobCredentialsJson != null) {
        final sicoobCredentials = SicoobApiCredentialsModel.fromJson(
          sicoobCredentialsJson,
        );
        return sicoobCredentials;
      } else {
        return null;
      }
    } catch (e) {
      _registerLog(e);
      _sendLogsToWeb(e);
      throw ErrorReadingApiCredentials(
        message: 'Não foi possivel recuperar suas credenciais, tente novamente',
      );
    }
  }

  @override
  Future<void> updateSicoobApiCredentials({
    required String id,
    required String clientID,
    required String certificatePassword,
    required String certificateBase64String,
    required bool isFavorite,
  }) async {
    try {
      final bbCredentialsJson = _sharedPreferences.getString(
        DocumentName.bbApiCredential.name,
      );
      if (bbCredentialsJson != null) {
        final sicoobCredentials = SicoobApiCredentialsModel.fromJson(
          bbCredentialsJson,
        );
        final updatedBbCredentials = sicoobCredentials.copyWith(
          clientID: clientID,
          certificateBase64String: certificateBase64String,
          certificatePassword: certificatePassword,
          isFavorite: isFavorite,
        );
        final saved = await _sharedPreferences.setString(
          DocumentName.sicoobApiCredential.name,
          updatedBbCredentials.toJson(),
        );
        if (saved != true) {
          const logError =
              'SharedPreferencesError: Error on Update BBApiCredentials';
          _sendLogsToWeb(logError);
          _registerLog(logError);
          throw ErrorSavingApiCredentials(
            message:
                'Ocorreu um erro ao atualizar as credenciais, tente novamente',
          );
        }
      } else {
        const logError =
            'SharedPreferencesError: Error on Update BBApiCredentials, BBApiCredentials not found';
        _sendLogsToWeb(logError);
        _registerLog(logError);
        throw ErrorReadingApiCredentials(
          message:
              'Não foi possível atualizar suas credenciais, tente novamente',
        );
      }
    } on ErrorReadingApiCredentials {
      rethrow;
    } catch (e) {
      _registerLog(e);
      _sendLogsToWeb(e);
      throw ErrorUpdateApiCredentials(
        message: 'Ocorreu um erro ao atualizar as credenciais, tente novamente',
      );
    }
  }

  @override
  Future<void> deleteSicoobApiCredentials({
    required String id,
  }) async {
    try {
      final removed = await _sharedPreferences.remove(
        DocumentName.sicoobApiCredential.name,
      );
      if (removed != true) {
        const logError =
            'SharedPreferencesError: Error on remove BBApiCredentials';
        _sendLogsToWeb(logError);
        _registerLog(logError);
        throw ErrorRemovingApiCredentials(
          message: 'Ocorreu um erro ao remover as credenciais, tente novamente',
        );
      }
    } catch (e) {
      _registerLog(e);
      _sendLogsToWeb(e);
      throw ErrorRemovingApiCredentials(
        message: 'Ocorreu um erro ao remover as credenciais, tente novamente',
      );
    }
  }

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
