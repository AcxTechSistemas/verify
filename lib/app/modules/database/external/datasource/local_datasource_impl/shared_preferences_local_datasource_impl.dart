import 'package:verify/app/core/register_log.dart';
import 'package:verify/app/core/send_logs_to_web.dart';
import 'package:verify/app/modules/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/modules/database/infra/datasource/api_credentials_datasource.dart';
import 'package:verify/app/modules/database/infra/models/sicoob_api_credentials_model.dart';
import 'package:verify/app/modules/database/infra/models/bb_api_credentials_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DocumentName {
  bbApiCredential,
  sicoobApiCredential,
}

class SharedPreferencesLocalDataSourceImpl implements ApiCredentialsDataSource {
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
          message: 'Ocorreu um erro ao salvar as credenciais, tente novamente',
        );
      }
    } catch (e) {
      _registerLog(e);
      _sendLogsToWeb(e);
      throw ErrorRemovingApiCredentials(
        message: 'Ocorreu um erro ao salvar as credenciais, tente novamente',
      );
    }
  }

  @override
  Future<void> saveSicoobApiCredentials(
      {required String id,
      required String clientID,
      required String certificatePassword,
      required String certificateBase64String,
      required bool isFavorite}) {
    // TODO: implement saveSicoobApiCredentials
    throw UnimplementedError();
  }

  @override
  Future<SicoobApiCredentialsModel?> readSicoobApiCredentials(
      {required String id}) {
    // TODO: implement readSicoobApiCredentials
    throw UnimplementedError();
  }

  @override
  Future<void> updateSicoobApiCredentials(
      {required String id,
      required String clientID,
      required String certificatePassword,
      required String certificateBase64String,
      required bool isFavorite}) {
    // TODO: implement updateSicoobApiCredentials
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSicoobApiCredentials({required String id}) {
    // TODO: implement deleteSicoobApiCredentials
    throw UnimplementedError();
  }
}
