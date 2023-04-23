import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:verify/app/modules/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/modules/database/infra/datasource/local_api_credentials_datasource.dart';
import 'package:verify/app/modules/database/infra/models/sicoob_api_credentials_model.dart';
import 'package:verify/app/modules/database/infra/models/bb_api_credentials_model.dart';
import 'package:verify/app/modules/database/utils/database_enums.dart';
import 'package:verify/app/shared/error_registrator/register_log.dart';
import 'package:verify/app/shared/error_registrator/send_logs_to_web.dart';

class LocalApiCredentialsDataSourceImpl
    implements LocalApiCredentialsDataSource {
  final FlutterSecureStorage _flutterSecureStorage;
  final RegisterLog _registerLog;
  final SendLogsToWeb _sendLogsToWeb;
  LocalApiCredentialsDataSourceImpl(
    this._flutterSecureStorage,
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
      await _flutterSecureStorage.write(
        key: DocumentName.bbApiCredential.name,
        value: bbCredentials.toJson(),
      );
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
      final bbCredentialsJson = await _flutterSecureStorage.read(
        key: DocumentName.bbApiCredential.name,
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
      final bbCredentialsJson = await _flutterSecureStorage.read(
        key: DocumentName.bbApiCredential.name,
      );
      if (bbCredentialsJson != null) {
        final bbCredentials = BBApiCredentialsModel.fromJson(bbCredentialsJson);
        final updatedBbCredentials = bbCredentials.copyWith(
          applicationDeveloperKey: applicationDeveloperKey,
          basicKey: basicKey,
          isFavorite: isFavorite,
        );
        await _flutterSecureStorage.write(
          key: DocumentName.bbApiCredential.name,
          value: updatedBbCredentials.toJson(),
        );
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
      _flutterSecureStorage.delete(
        key: DocumentName.bbApiCredential.name,
      );
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
      await _flutterSecureStorage.write(
        key: DocumentName.sicoobApiCredential.name,
        value: sicoobCredentials.toJson(),
      );
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
      final sicoobCredentialsJson = await _flutterSecureStorage.read(
        key: DocumentName.sicoobApiCredential.name,
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
      final sicoobCredentialsJson = await _flutterSecureStorage.read(
        key: DocumentName.sicoobApiCredential.name,
      );
      if (sicoobCredentialsJson != null) {
        final sicoobCredentials = SicoobApiCredentialsModel.fromJson(
          sicoobCredentialsJson,
        );
        final updatedBbCredentials = sicoobCredentials.copyWith(
          clientID: clientID,
          certificateBase64String: certificateBase64String,
          certificatePassword: certificatePassword,
          isFavorite: isFavorite,
        );
        await _flutterSecureStorage.write(
          key: DocumentName.sicoobApiCredential.name,
          value: updatedBbCredentials.toJson(),
        );
      } else {
        const logError =
            'SharedPreferencesError: Error on Update SicoobApiCredentials, SicoobApiCredentials not found';
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
      await _flutterSecureStorage.delete(
        key: DocumentName.sicoobApiCredential.name,
      );
    } catch (e) {
      _registerLog(e);
      _sendLogsToWeb(e);
      throw ErrorRemovingApiCredentials(
        message: 'Ocorreu um erro ao remover as credenciais, tente novamente',
      );
    }
  }
}
