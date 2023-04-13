import 'package:result_dart/result_dart.dart';
import 'package:verify/app/features/database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/features/database/domain/entities/sicoob_api_credentials_entity.dart';
import 'package:verify/app/features/database/domain/errors/api_credentials_error.dart';

abstract class ApiCredentialsRepository {
  // SicoobApiCredentials
  Future<Result<void, ApiCredentialsError>> saveSicoobApiCredentials({
    required String id,
    required SicoobApiCredentialsEntity sicoobApiCredentialsEntity,
  });
  Future<Result<void, ApiCredentialsError>> updateSicoobApiCredentials({
    required String id,
    required SicoobApiCredentialsEntity sicoobApiCredentialsEntity,
  });
  Future<Result<SicoobApiCredentialsEntity, ApiCredentialsError>>
      readSicoobApiCredentials({
    required String id,
  });
  Future<Result<void, ApiCredentialsError>> removeSicoobApiCredentials({
    required String id,
  });

  // BBApiCredentials
  Future<Result<void, ApiCredentialsError>> saveBBApiCredentials({
    required String id,
    required BBApiCredentialsEntity bbApiCredentialsEntity,
  });
  Future<Result<void, ApiCredentialsError>> updateBBApiCredentials({
    required String id,
    required BBApiCredentialsEntity bbApiCredentialsEntity,
  });
  Future<Result<BBApiCredentialsEntity, ApiCredentialsError>>
      readBBApiCredentials({
    required String id,
  });
  Future<Result<void, ApiCredentialsError>> removeBBApiCredentials({
    required String id,
  });
}
