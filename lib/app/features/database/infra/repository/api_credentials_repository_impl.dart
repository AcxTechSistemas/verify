import 'dart:ffi';

import 'package:result_dart/result_dart.dart';
import 'package:verify/app/features/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/features/database/domain/entities/sicoob_api_credentials_entity.dart';
import 'package:verify/app/features/database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/features/database/domain/repository/api_credentials_repository.dart';
import 'package:verify/app/features/database/infra/datasource/api_credentials_datasource.dart';

class ApiCredentialsRepositoryImpl implements ApiCredentialsRepository {
  final ApiCredentialsDataSource _apiCredentialsDataSource;
  ApiCredentialsRepositoryImpl(this._apiCredentialsDataSource);
  @override
  Future<Result<BBApiCredentialsEntity, ApiCredentialsError>>
      readBBApiCredentials() async {
    try {
      final bbApiCredential =
          await _apiCredentialsDataSource.readBBApiCredentials();
      return Success(bbApiCredential);
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
  Future<Result<SicoobApiCredentialsEntity, ApiCredentialsError>>
      readSicoobApiCredentials() async {
    try {
      final sicoobApiCredential =
          await _apiCredentialsDataSource.readSicoobApiCredentials();
      return Success(sicoobApiCredential);
    } on ErrorReadingApiCredentials catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(ErrorReadingApiCredentials(
        message: 'Ocorreu um erro ao recuperar as credenciais do Sicoob',
      ));
    }
  }

  @override
  Future<Result<void, ApiCredentialsError>> removeBBApiCredentials() async {
    try {
      await _apiCredentialsDataSource.deleteBBApiCredentials();
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
  Future<Result<void, ApiCredentialsError>> removeSicoobApiCredentials() async {
    try {
      await _apiCredentialsDataSource.deleteSicoobApiCredentials();
      return const Success(Void);
    } on ErrorRemovingApiCredentials catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(ErrorRemovingApiCredentials(
        message: 'Ocorreu um erro ao remover as credenciais do Sicoob',
      ));
    }
  }

  @override
  Future<Result<void, ApiCredentialsError>> saveBBApiCredentials({
    required BBApiCredentialsEntity bbApiCredentialsEntity,
  }) async {
    try {
      await _apiCredentialsDataSource.saveBBApiCredentials(
        bbApiCredentialsEntity: bbApiCredentialsEntity,
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
  Future<Result<void, ApiCredentialsError>> saveSicoobApiCredentials({
    required SicoobApiCredentialsEntity sicoobApiCredentialsEntity,
  }) async {
    try {
      await _apiCredentialsDataSource.saveSicoobApiCredentials(
        sicoobApiCredentialsEntity: sicoobApiCredentialsEntity,
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
  Future<Result<void, ApiCredentialsError>> updateBBApiCredentials({
    required BBApiCredentialsEntity bbApiCredentialsEntity,
  }) async {
    try {
      await _apiCredentialsDataSource.updateBBApiCredentials(
        bbApiCredentialsEntity: bbApiCredentialsEntity,
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
  Future<Result<void, ApiCredentialsError>> updateSicoobApiCredentials({
    required SicoobApiCredentialsEntity sicoobApiCredentialsEntity,
  }) async {
    try {
      await _apiCredentialsDataSource.updateSicoobApiCredentials(
        sicoobApiCredentialsEntity: sicoobApiCredentialsEntity,
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
}
