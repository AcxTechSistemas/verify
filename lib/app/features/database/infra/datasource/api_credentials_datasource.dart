import 'package:verify/app/features/database/infra/models/bb_api_credentials_model.dart';
import 'package:verify/app/features/database/infra/models/sicoob_api_credentials_model.dart';

abstract class ApiCredentialsDataSource {
  // Sicoob
  Future<void> saveSicoobApiCredentials({
    required String id,
    required String clientID,
    required String certificatePassword,
    required String certificateBase64String,
    required bool isFavorite,
  });
  Future<void> updateSicoobApiCredentials({
    required String id,
    required String clientID,
    required String certificatePassword,
    required String certificateBase64String,
    required bool isFavorite,
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
    required String applicationDeveloperKey,
    required String basicKey,
    required bool isFavorite,
  });
  Future<void> updateBBApiCredentials({
    required String id,
    required String applicationDeveloperKey,
    required String basicKey,
    required bool isFavorite,
  });
  Future<BBApiCredentialsModel> readBBApiCredentials({
    required String id,
  });
  Future<void> deleteBBApiCredentials({
    required String id,
  });
}
