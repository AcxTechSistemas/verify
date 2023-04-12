import 'package:result_dart/result_dart.dart';
import 'package:verify/app/features/database/domain/entities/sicoob_api_credentials_entity.dart';
import 'package:verify/app/features/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/features/database/domain/repository/api_credentials_repository.dart';

abstract class SaveSicoobApiCredentialsUseCase {
  Future<Result<void, ApiCredentialsError>> call({
    required SicoobApiCredentialsEntity sicoobApiCredentialsEntity,
  });
}

class SaveSicoobApiCredentialsUseCaseImpl
    implements SaveSicoobApiCredentialsUseCase {
  final ApiCredentialsRepository _apiCredentialsRepository;
  SaveSicoobApiCredentialsUseCaseImpl(this._apiCredentialsRepository);

  @override
  Future<Result<void, ApiCredentialsError>> call({
    required SicoobApiCredentialsEntity sicoobApiCredentialsEntity,
  }) async {
    return await _apiCredentialsRepository.saveSicoobApiCredentials(
      sicoobApiCredentialsEntity: sicoobApiCredentialsEntity,
    );
  }
}
