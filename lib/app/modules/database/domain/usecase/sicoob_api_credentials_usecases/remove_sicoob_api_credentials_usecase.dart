import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/modules/database/domain/repository/api_credentials_repository.dart';
import 'package:verify/app/modules/database/utils/database_enums.dart';

abstract class RemoveSicoobApiCredentialsUseCase {
  Future<Result<void, ApiCredentialsError>> call({
    required Database database,
    required String id,
  });
}

class RemoveSicoobApiCredentialsUseCaseImpl
    implements RemoveSicoobApiCredentialsUseCase {
  final ApiCredentialsRepository _apiCredentialsRepository;
  RemoveSicoobApiCredentialsUseCaseImpl(this._apiCredentialsRepository);
  @override
  Future<Result<void, ApiCredentialsError>> call({
    required Database database,
    required String id,
  }) async {
    return await _apiCredentialsRepository.removeSicoobApiCredentials(
      database: database,
      id: id,
    );
  }
}
