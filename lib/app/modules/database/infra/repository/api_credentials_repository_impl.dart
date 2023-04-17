import 'dart:ffi';

import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/modules/database/domain/entities/sicoob_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/repository/api_credentials_repository.dart';
import 'package:verify/app/modules/database/infra/datasource/api_credentials_datasource.dart';
import 'package:verify/app/modules/database/infra/datasource/cloud_api_credentials_datasource.dart';
import 'package:verify/app/modules/database/infra/datasource/local_api_credentials_datasource.dart';
import 'package:verify/app/modules/database/utils/database_enums.dart';

class ApiCredentialsRepositoryImpl implements ApiCredentialsRepository {
  late ApiCredentialsDataSource _apiCredentialsDataSource;
  final CloudApiCredentialsDataSource _cloudApiCredentialsDataSource;
  final LocalApiCredentialsDataSource _localApiCredentialsDataSource;

  ApiCredentialsRepositoryImpl(
    this._cloudApiCredentialsDataSource,
    this._localApiCredentialsDataSource,
  );

  void selectDataSource(Database database) {
    switch (database) {
      case Database.cloud:
        _apiCredentialsDataSource = _cloudApiCredentialsDataSource;
        break;
      case Database.local:
        _apiCredentialsDataSource = _localApiCredentialsDataSource;
        break;
    }
  }

  @override
  Future<Result<void, ApiCredentialsError>> saveBBApiCredentials({
    required Database database,
    required String id,
    required String applicationDeveloperKey,
    required String basicKey,
    required bool isFavorite,
  }) async {
    selectDataSource(database);
    try {
      await _apiCredentialsDataSource.saveBBApiCredentials(
        id: id,
        applicationDeveloperKey: applicationDeveloperKey,
        basicKey: basicKey,
        isFavorite: isFavorite,
      );
      return const Success(Void);
    } on ErrorSavingApiCredentials catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(ErrorSavingApiCredentials(
        message: 'Ocorreu um erro ao salvar as credenciais do Banco do Brasil',
      ));
    }
  }

  @override
  Future<Result<BBApiCredentialsEntity, ApiCredentialsError>>
      readBBApiCredentials({
    required Database database,
    required String id,
  }) async {
    selectDataSource(database);
    try {
      final bbApiCredential =
          await _apiCredentialsDataSource.readBBApiCredentials(id: id);
      if (bbApiCredential != null) {
        return Success(bbApiCredential);
      } else {
        return Failure(EmptyApiCredentials(
          message: 'Credenciais não existem na nuvem',
        ));
      }
    } on ErrorReadingApiCredentials catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(
        ErrorReadingApiCredentials(
          message:
              'Ocorreu um erro ao recuperar as credenciais do Banco do Brasil',
        ),
      );
    }
  }

  @override
  Future<Result<void, ApiCredentialsError>> updateBBApiCredentials({
    required Database database,
    required String id,
    required String applicationDeveloperKey,
    required String basicKey,
    required bool isFavorite,
  }) async {
    selectDataSource(database);
    try {
      await _apiCredentialsDataSource.updateBBApiCredentials(
        id: id,
        applicationDeveloperKey: applicationDeveloperKey,
        basicKey: basicKey,
        isFavorite: isFavorite,
      );
      return const Success(Void);
    } on ErrorUpdateApiCredentials catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(ErrorUpdateApiCredentials(
        message:
            'Ocorreu um erro ao atualizar as credenciais do Banco do Brasil',
      ));
    }
  }

  @override
  Future<Result<void, ApiCredentialsError>> removeBBApiCredentials({
    required Database database,
    required String id,
  }) async {
    selectDataSource(database);
    try {
      await _apiCredentialsDataSource.deleteBBApiCredentials(id: id);
      return const Success(Void);
    } on ErrorRemovingApiCredentials catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(ErrorRemovingApiCredentials(
        message: 'Ocorreu um erro ao remover as credenciais do Banco do Brasil',
      ));
    }
  }

  @override
  Future<Result<void, ApiCredentialsError>> saveSicoobApiCredentials({
    required Database database,
    required String id,
    required String clientID,
    required String certificatePassword,
    required String certificateBase64String,
    required bool isFavorite,
  }) async {
    selectDataSource(database);
    try {
      await _apiCredentialsDataSource.saveSicoobApiCredentials(
        id: id,
        clientID: clientID,
        certificateBase64String: certificateBase64String,
        certificatePassword: certificatePassword,
        isFavorite: isFavorite,
      );
      return const Success(Void);
    } on ErrorSavingApiCredentials catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(ErrorSavingApiCredentials(
        message: 'Ocorreu um erro ao salvar as credenciais do Sicoob',
      ));
    }
  }

  @override
  Future<Result<SicoobApiCredentialsEntity, ApiCredentialsError>>
      readSicoobApiCredentials({
    required Database database,
    required String id,
  }) async {
    selectDataSource(database);
    try {
      final sicoobApiCredential =
          await _apiCredentialsDataSource.readSicoobApiCredentials(id: id);

      if (sicoobApiCredential != null) {
        return Success(sicoobApiCredential);
      } else {
        return Failure(EmptyApiCredentials(
          message: 'Credenciais não existem na nuvem',
        ));
      }
    } on ErrorReadingApiCredentials catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(ErrorReadingApiCredentials(
        message: 'Ocorreu um erro ao recuperar as credenciais do Sicoob',
      ));
    }
  }

  @override
  Future<Result<void, ApiCredentialsError>> updateSicoobApiCredentials({
    required Database database,
    required String id,
    required String clientID,
    required String certificatePassword,
    required String certificateBase64String,
    required bool isFavorite,
  }) async {
    selectDataSource(database);
    try {
      await _apiCredentialsDataSource.updateSicoobApiCredentials(
        id: id,
        clientID: clientID,
        certificateBase64String: certificateBase64String,
        certificatePassword: certificatePassword,
        isFavorite: isFavorite,
      );
      return const Success(Void);
    } on ErrorUpdateApiCredentials catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(ErrorUpdateApiCredentials(
        message: 'Ocorreu um erro ao atualizar as credenciais do Sicoob',
      ));
    }
  }

  @override
  Future<Result<void, ApiCredentialsError>> removeSicoobApiCredentials({
    required Database database,
    required String id,
  }) async {
    selectDataSource(database);
    try {
      await _apiCredentialsDataSource.deleteSicoobApiCredentials(id: id);
      return const Success(Void);
    } on ErrorRemovingApiCredentials catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(ErrorRemovingApiCredentials(
        message: 'Ocorreu um erro ao remover as credenciais do Sicoob',
      ));
    }
  }
}
