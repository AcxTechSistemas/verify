import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/features/database/local_database/domain/entities/sicoob_api_credentials_entity.dart';
import 'package:verify/app/features/database/local_database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/features/database/local_database/domain/repository/local_database_repository.dart';
import 'package:verify/app/features/database/local_database/domain/usecase/sicoob_api_credentials_usecases/save_sicoob_api_credentials_usecase.dart';

class MockLocalDataBaseRepository extends Mock
    implements LocalDataBaseRepository {}

void main() {
  late SaveSicoobApiCredentialsUseCase saveSicoobApiCredentialsUseCase;
  late LocalDataBaseRepository localDataBaseRepository;
  late SicoobApiCredentialsEntity sicoobApiCredentialsEntity;

  setUp(() {
    localDataBaseRepository = MockLocalDataBaseRepository();
    saveSicoobApiCredentialsUseCase = SaveSicoobApiCredentialsUseCaseImpl(
      localDataBaseRepository,
    );
    sicoobApiCredentialsEntity = SicoobApiCredentialsEntity(
      certificateBase64String: '',
      certificatePassword: '',
      clientID: '',
      isFavorite: false,
    );
    registerFallbackValue(sicoobApiCredentialsEntity);
  });

  group('SaveSicoobApiCredentialsUseCase: ', () {
    test('Verify called saveSicoobApiCredentials and return Success', () async {
      when(() => localDataBaseRepository.saveSicoobApiCredentials(
              sicoobApiCredentialsEntity:
                  any(named: 'sicoobApiCredentialsEntity')))
          .thenAnswer((_) async => const Success(Void));

      final response = await saveSicoobApiCredentialsUseCase(
        sicoobApiCredentialsEntity: sicoobApiCredentialsEntity,
      );

      expect(response.isSuccess(), true);

      verify(() => localDataBaseRepository.saveSicoobApiCredentials(
          sicoobApiCredentialsEntity:
              any(named: 'sicoobApiCredentialsEntity'))).called(1);
    });

    test('Should return ApiCredentialsError on failure', () async {
      final apiCredentialsError = ErrorSavingApiCredentials(
        message: 'Error Saving Credentials',
      );

      when(() => localDataBaseRepository.saveSicoobApiCredentials(
              sicoobApiCredentialsEntity:
                  any(named: 'sicoobApiCredentialsEntity')))
          .thenAnswer((_) async => Failure(apiCredentialsError));

      final response = await saveSicoobApiCredentialsUseCase(
        sicoobApiCredentialsEntity: sicoobApiCredentialsEntity,
      );

      expect(response.isError(), true);

      verify(() => localDataBaseRepository.saveSicoobApiCredentials(
          sicoobApiCredentialsEntity:
              any(named: 'sicoobApiCredentialsEntity'))).called(1);

      final result = response.exceptionOrNull();

      expect(result, isNotNull);
      expect(result!.message, equals('Error Saving Credentials'));
    });
  });
}
