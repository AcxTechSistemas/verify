import 'package:verify/app/features/database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/features/database/domain/entities/sicoob_api_credentials_entity.dart';
import 'package:verify/app/features/database/infra/models/bb_api_credentials_model.dart';
import 'package:verify/app/features/database/infra/models/sicoob_api_credentials_model.dart';

abstract class ApiCredentialsDataSource {
  // Sicoob
  Future<void> saveSicoobApiCredentials({
    required SicoobApiCredentialsEntity sicoobApiCredentialsEntity,
  });
  Future<void> updateSicoobApiCredentials({
    required SicoobApiCredentialsEntity sicoobApiCredentialsEntity,
  });
  Future<SicoobApiCredentialsModel> readSicoobApiCredentials();
  Future<void> deleteSicoobApiCredentials();

  // BB
  Future<void> saveBBApiCredentials({
    required BBApiCredentialsEntity bbApiCredentialsEntity,
  });
  Future<void> updateBBApiCredentials({
    required BBApiCredentialsEntity bbApiCredentialsEntity,
  });
  Future<BBApiCredentialsModel> readBBApiCredentials();
  Future<void> deleteBBApiCredentials();
}
