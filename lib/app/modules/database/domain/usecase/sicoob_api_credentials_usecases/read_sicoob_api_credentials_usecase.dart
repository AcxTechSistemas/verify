import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/database/domain/entities/sicoob_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/modules/database/domain/repository/api_credentials_repository.dart';

abstract class ReadSicoobApiCredentialsUseCase {
  Future<Result<SicoobApiCredentialsEntity, ApiCredentialsError>> call({
    required String id,
  });
}

class ReadSicoobApiCredentialsUseCaseImpl
    implements ReadSicoobApiCredentialsUseCase {
  final ApiCredentialsRepository _apiCredentialsRepository;
  ReadSicoobApiCredentialsUseCaseImpl(this._apiCredentialsRepository);
  @override
  Future<Result<SicoobApiCredentialsEntity, ApiCredentialsError>> call({
    required String id,
  }) async {
    return await _apiCredentialsRepository.readSicoobApiCredentials(id: id);
  }
}
