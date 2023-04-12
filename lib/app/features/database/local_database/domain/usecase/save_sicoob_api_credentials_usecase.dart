import 'package:result_dart/result_dart.dart';
import 'package:verify/app/features/database/local_database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/features/database/local_database/domain/repository/local_database_repository.dart';

abstract class SaveSicoobApiCredentialsUseCase {
  Future<Result<void, ApiCredentialsError>> call();
}

class SaveSicoobApiCredentialsUseCaseImpl
    implements SaveSicoobApiCredentialsUseCase {
  final LocalDataBaseRepository _localDataBaseRepository;
  SaveSicoobApiCredentialsUseCaseImpl(this._localDataBaseRepository);

  @override
  Future<Result<void, ApiCredentialsError>> call() async {
    return await _localDataBaseRepository.saveSicoobApiCredentials();
  }
}
