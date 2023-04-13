import 'package:verify/app/features/database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/features/database/domain/entities/sicoob_api_credentials_entity.dart';
import 'package:verify/app/features/database/infra/models/bb_api_credentials_model.dart';
import 'package:verify/app/features/database/infra/models/sicoob_api_credentials_model.dart';

abstract class ApiCredentialsDataSource {
  // Sicoob
  Future<void> saveSicoobApiCredentials({
    required String id,
    required SicoobApiCredentialsEntity sicoobApiCredentialsEntity,
  });
  Future<void> updateSicoobApiCredentials({
    required String id,
    required SicoobApiCredentialsEntity sicoobApiCredentialsEntity,
  });
  Future<SicoobApiCredentialsModel> readSicoobApiCredentials({
    required String id,
  });
  Future<void> deleteSicoobApiCredentials({
    required String id,
  });

  // BB
  Future<void> saveBBApiCredentials({
    required String id,
    required BBApiCredentialsEntity bbApiCredentialsEntity,
  });
  Future<void> updateBBApiCredentials({
    required String id,
    required BBApiCredentialsEntity bbApiCredentialsEntity,
  });
  Future<BBApiCredentialsModel> readBBApiCredentials({
    required String id,
  });
  Future<void> deleteBBApiCredentials({
    required String id,
  });
}
