import 'package:result_dart/result_dart.dart';
import 'package:verify/app/features/database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/features/database/domain/entities/sicoob_api_credentials_entity.dart';
import 'package:verify/app/features/database/domain/errors/api_credentials_error.dart';

abstract class ApiCredentialsRepository {
  // SicoobApiCredentials
  Future<Result<void, ApiCredentialsError>> saveSicoobApiCredentials({
    required SicoobApiCredentialsEntity sicoobApiCredentialsEntity,
  });
  Future<Result<void, ApiCredentialsError>> updateSicoobApiCredentials({
    required SicoobApiCredentialsEntity sicoobApiCredentialsEntity,
  });
  Future<Result<SicoobApiCredentialsEntity, ApiCredentialsError>>
      readSicoobApiCredentials();
  Future<Result<void, ApiCredentialsError>> removeSicoobApiCredentials();

  // BBApiCredentials
  Future<Result<void, ApiCredentialsError>> saveBBApiCredentials({
    required BBApiCredentialsEntity bbApiCredentialsEntity,
  });
  Future<Result<void, ApiCredentialsError>> updateBBApiCredentials({
    required BBApiCredentialsEntity bbApiCredentialsEntity,
  });
  Future<Result<BBApiCredentialsEntity, ApiCredentialsError>>
      readBBApiCredentials();
  Future<Result<void, ApiCredentialsError>> removeBBApiCredentials();
}
