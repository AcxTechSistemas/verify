import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/database/domain/entities/sicoob_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/modules/database/domain/repository/api_credentials_repository.dart';

abstract class UpdateSicoobApiCredentialsUseCase {
  Future<Result<void, ApiCredentialsError>> call({
    required String id,
    required SicoobApiCredentialsEntity sicoobApiCredentialsEntity,
  });
}

class UpdateSicoobApiCredentialsUseCaseImpl
    implements UpdateSicoobApiCredentialsUseCase {
  final ApiCredentialsRepository _apiCredentialsRepository;
  UpdateSicoobApiCredentialsUseCaseImpl(this._apiCredentialsRepository);
  @override
  Future<Result<void, ApiCredentialsError>> call({
    required String id,
    required SicoobApiCredentialsEntity sicoobApiCredentialsEntity,
  }) async {
    return await _apiCredentialsRepository.updateSicoobApiCredentials(
      id: id,
      clientID: sicoobApiCredentialsEntity.clientID,
      certificateBase64String: sicoobApiCredentialsEntity.clientID,
      certificatePassword: sicoobApiCredentialsEntity.certificatePassword,
      isFavorite: sicoobApiCredentialsEntity.isFavorite,
    );
  }
}