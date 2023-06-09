import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/modules/database/domain/repository/api_credentials_repository.dart';
import 'package:verify/app/modules/database/utils/database_enums.dart';

abstract class ReadBBApiCredentialsUseCase {
  Future<Result<BBApiCredentialsEntity, ApiCredentialsError>> call({
    required Database database,
    required String id,
  });
}

class ReadBBApiCredentialsUseCaseImpl implements ReadBBApiCredentialsUseCase {
  final ApiCredentialsRepository _apiCredentialsRepository;
  ReadBBApiCredentialsUseCaseImpl(this._apiCredentialsRepository);
  @override
  Future<Result<BBApiCredentialsEntity, ApiCredentialsError>> call({
    required Database database,
    required String id,
  }) async {
    return await _apiCredentialsRepository.readBBApiCredentials(
      database: database,
      id: id,
    );
  }
}
