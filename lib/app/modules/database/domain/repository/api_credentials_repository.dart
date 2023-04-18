import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/entities/sicoob_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/modules/database/utils/database_enums.dart';

abstract class ApiCredentialsRepository {
  // SicoobApiCredentials
  Future<Result<void, ApiCredentialsError>> saveSicoobApiCredentials({
    required Database database,
    required String id,
    required String clientID,
    required String certificatePassword,
    required String certificateBase64String,
    required bool isFavorite,
  });
  Future<Result<void, ApiCredentialsError>> updateSicoobApiCredentials({
    required Database database,
    required String id,
    required String clientID,
    required String certificatePassword,
    required String certificateBase64String,
    required bool isFavorite,
  });
  Future<Result<SicoobApiCredentialsEntity, ApiCredentialsError>>
      readSicoobApiCredentials({
    required Database database,
    required String id,
  });
  Future<Result<void, ApiCredentialsError>> removeSicoobApiCredentials({
    required Database database,
    required String id,
  });

  // BBApiCredentials
  Future<Result<void, ApiCredentialsError>> saveBBApiCredentials({
    required Database database,
    required String id,
    required String applicationDeveloperKey,
    required String basicKey,
    required bool isFavorite,
  });
  Future<Result<void, ApiCredentialsError>> updateBBApiCredentials({
    required Database database,
    required String id,
    required String applicationDeveloperKey,
    required String basicKey,
    required bool isFavorite,
  });
  Future<Result<BBApiCredentialsEntity, ApiCredentialsError>>
      readBBApiCredentials({
    required Database database,
    required String id,
  });
  Future<Result<void, ApiCredentialsError>> removeBBApiCredentials({
    required Database database,
    required String id,
  });
}
