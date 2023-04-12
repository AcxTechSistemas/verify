import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/features/database/local_database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/features/database/local_database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/features/database/local_database/domain/repository/local_database_repository.dart';
import 'package:verify/app/features/database/local_database/domain/usecase/bb_api_credentials_usecases/save_bb_api_credentials_usecase.dart';

class MockLocalDataBaseRepository extends Mock
    implements LocalDataBaseRepository {}

void main() {
  late SaveBBApiCredentialsUseCase saveBBApiCredentialsUseCase;
  late LocalDataBaseRepository localDataBaseRepository;
  late BBApiCredentialsEntity bbApiCredentialsEntity;

  setUp(() {
    localDataBaseRepository = MockLocalDataBaseRepository();
    saveBBApiCredentialsUseCase = SaveBBApiCredentialsUseCaseImpl(
      localDataBaseRepository,
    );
    bbApiCredentialsEntity = BBApiCredentialsEntity(
      applicationDeveloperKey: '',
      basicKey: '',
      isFavorite: false,
    );
    registerFallbackValue(bbApiCredentialsEntity);
  });

  group('SaveBBApiCredentialsUseCase: ', () {
    test('Verify called saveBBApiCredentials and return Success', () async {
      when(() => localDataBaseRepository.saveBBApiCredentials(
            bbApiCredentialsEntity: any(named: 'bbApiCredentialsEntity'),
          )).thenAnswer((_) async => const Success(Void));

      final response = await saveBBApiCredentialsUseCase(
        bbApiCredentialsEntity: bbApiCredentialsEntity,
      );

      verify(() => localDataBaseRepository.saveBBApiCredentials(
              bbApiCredentialsEntity: any(named: 'bbApiCredentialsEntity')))
          .called(1);

      expect(response.isSuccess(), true);
    });

    test('Should return ApiCredentialsError on failure', () async {
      final apiCredentialsError = ErrorSavingApiCredentials(
        message: 'Error Saving Credentials',
      );

      when(
        () => localDataBaseRepository.saveBBApiCredentials(
            bbApiCredentialsEntity: any(named: 'bbApiCredentialsEntity')),
      ).thenAnswer((_) async => Failure(apiCredentialsError));

      final response = await saveBBApiCredentialsUseCase(
        bbApiCredentialsEntity: bbApiCredentialsEntity,
      );

      expect(response.isError(), true);

      verify(() => localDataBaseRepository.saveBBApiCredentials(
              bbApiCredentialsEntity: any(named: 'bbApiCredentialsEntity')))
          .called(1);

      final result = response.exceptionOrNull();

      expect(result, isNotNull);
      expect(result!.message, equals('Error Saving Credentials'));
    });
  });
}
