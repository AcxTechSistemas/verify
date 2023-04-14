import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/modules/database/domain/repository/api_credentials_repository.dart';

abstract class UpdateBBApiCredentialsUseCase {
  Future<Result<void, ApiCredentialsError>> call({
    required String id,
    required BBApiCredentialsEntity bbApiCredentialsEntity,
  });
}

class UpdateBBApiCredentialsUseCaseImpl
    implements UpdateBBApiCredentialsUseCase {
  final ApiCredentialsRepository _apiCredentialsRepository;
  UpdateBBApiCredentialsUseCaseImpl(this._apiCredentialsRepository);
  @override
  Future<Result<void, ApiCredentialsError>> call({
    required String id,
    required BBApiCredentialsEntity bbApiCredentialsEntity,
  }) async {
    return await _apiCredentialsRepository.updateBBApiCredentials(
      id: id,
      applicationDeveloperKey: bbApiCredentialsEntity.applicationDeveloperKey,
      basicKey: bbApiCredentialsEntity.basicKey,
      isFavorite: bbApiCredentialsEntity.isFavorite,
    );
  }
}
