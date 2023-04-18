import 'package:verify/app/modules/database/infra/datasource/api_credentials_datasource.dart';
import 'package:verify/app/modules/database/infra/models/bb_api_credentials_model.dart';
import 'package:verify/app/modules/database/infra/models/sicoob_api_credentials_model.dart';

abstract class LocalApiCredentialsDataSource extends ApiCredentialsDataSource {
  // Sicoob
  @override
  Future<void> saveSicoobApiCredentials({
    required String id,
    required String clientID,
    required String certificatePassword,
    required String certificateBase64String,
    required bool isFavorite,
  });
  @override
  Future<void> updateSicoobApiCredentials({
    required String id,
    required String clientID,
    required String certificatePassword,
    required String certificateBase64String,
    required bool isFavorite,
  });
  @override
  Future<SicoobApiCredentialsModel?> readSicoobApiCredentials({
    required String id,
  });
  @override
  Future<void> deleteSicoobApiCredentials({
    required String id,
  });

  // BB
  @override
  Future<void> saveBBApiCredentials({
    required String id,
    required String applicationDeveloperKey,
    required String basicKey,
    required bool isFavorite,
  });
  @override
  Future<void> updateBBApiCredentials({
    required String id,
    required String applicationDeveloperKey,
    required String basicKey,
    required bool isFavorite,
  });
  @override
  Future<BBApiCredentialsModel?> readBBApiCredentials({
    required String id,
  });
  @override
  Future<void> deleteBBApiCredentials({
    required String id,
  });
}
