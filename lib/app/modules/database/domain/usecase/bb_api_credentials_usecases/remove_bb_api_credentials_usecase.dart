import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/modules/database/domain/repository/api_credentials_repository.dart';

abstract class RemoveBBApiCredentialsUseCase {
  Future<Result<void, ApiCredentialsError>> call({
    required String id,
  });
}

class RemoveBBApiCredentialsUseCaseImpl
    implements RemoveBBApiCredentialsUseCase {
  final ApiCredentialsRepository _apiCredentialsRepository;
  RemoveBBApiCredentialsUseCaseImpl(this._apiCredentialsRepository);
  @override
  Future<Result<void, ApiCredentialsError>> call({
    required String id,
  }) async {
    return await _apiCredentialsRepository.removeBBApiCredentials(
      id: id,
    );
  }
}
