import 'package:result_dart/result_dart.dart';
import 'package:verify/app/features/database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/features/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/features/database/domain/repository/api_credentials_repository.dart';

abstract class ReadBBApiCredentialsUseCase {
  Future<Result<BBApiCredentialsEntity, ApiCredentialsError>> call({
    required String id,
  });
}

class ReadBBApiCredentialsUseCaseImpl implements ReadBBApiCredentialsUseCase {
  final ApiCredentialsRepository _apiCredentialsRepository;
  ReadBBApiCredentialsUseCaseImpl(this._apiCredentialsRepository);
  @override
  Future<Result<BBApiCredentialsEntity, ApiCredentialsError>> call({
    required String id,
  }) async {
    return await _apiCredentialsRepository.readBBApiCredentials(id: id);
  }
}
