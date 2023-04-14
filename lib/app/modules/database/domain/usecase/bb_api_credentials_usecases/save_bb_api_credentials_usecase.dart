import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/modules/database/domain/repository/api_credentials_repository.dart';

abstract class SaveBBApiCredentialsUseCase {
  Future<Result<void, ApiCredentialsError>> call({
    required String id,
    required BBApiCredentialsEntity bbApiCredentialsEntity,
  });
}

class SaveBBApiCredentialsUseCaseImpl implements SaveBBApiCredentialsUseCase {
  final ApiCredentialsRepository _apiCredentialsRepository;
  SaveBBApiCredentialsUseCaseImpl(this._apiCredentialsRepository);

  @override
  Future<Result<void, ApiCredentialsError>> call({
    required String id,
    required BBApiCredentialsEntity bbApiCredentialsEntity,
  }) async {
    return await _apiCredentialsRepository.saveBBApiCredentials(
      id: id,
      applicationDeveloperKey: bbApiCredentialsEntity.applicationDeveloperKey,
      basicKey: bbApiCredentialsEntity.basicKey,
      isFavorite: bbApiCredentialsEntity.isFavorite,
    );
  }
}
