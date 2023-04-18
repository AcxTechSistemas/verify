import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/modules/database/domain/repository/api_credentials_repository.dart';
import 'package:verify/app/modules/database/domain/usecase/bb_api_credentials_usecases/update_bb_api_credentials_usecase.dart';
import 'package:verify/app/modules/database/utils/database_enums.dart';

class MockApiCredentialsRepository extends Mock
    implements ApiCredentialsRepository {}

void main() {
  late UpdateBBApiCredentialsUseCase updateBBApiCredentialsUseCase;
  late ApiCredentialsRepository apiCredentialsRepository;
  late BBApiCredentialsEntity bbApiCredentialsEntity;
  late Database database;

  setUp(() {
    apiCredentialsRepository = MockApiCredentialsRepository();
    updateBBApiCredentialsUseCase = UpdateBBApiCredentialsUseCaseImpl(
      apiCredentialsRepository,
    );
    bbApiCredentialsEntity = BBApiCredentialsEntity(
      applicationDeveloperKey: '',
      basicKey: '',
      isFavorite: false,
    );
    database = Database.local;
    registerFallbackValue(database);
    registerFallbackValue(bbApiCredentialsEntity);
  });

  group('UpdateBBApiCredentialsUseCase: ', () {
    test('Should return success on saveBBApiCredentials', () async {
      when(
        () => apiCredentialsRepository.updateBBApiCredentials(
          database: any(named: 'database'),
          id: any(named: 'id'),
          applicationDeveloperKey: any(named: 'applicationDeveloperKey'),
          basicKey: any(named: 'basicKey'),
          isFavorite: any(named: 'isFavorite'),
        ),
      ).thenAnswer((_) async => const Success(Void));

      final response = await updateBBApiCredentialsUseCase(
        database: database,
        id: 'userID',
        bbApiCredentialsEntity: bbApiCredentialsEntity,
      );

      verify(
        () => apiCredentialsRepository.updateBBApiCredentials(
          database: database,
          id: 'userID',
          applicationDeveloperKey:
              bbApiCredentialsEntity.applicationDeveloperKey,
          basicKey: bbApiCredentialsEntity.basicKey,
          isFavorite: bbApiCredentialsEntity.isFavorite,
        ),
      ).called(1);

      expect(response.isSuccess(), true);
    });

    test('Should return ErrorSavingApiCredentials on saveBBApiCredentials',
        () async {
      final apiCredentialsError = ErrorSavingApiCredentials(
        message: 'Error Saving Credentials',
      );

      when(
        () => apiCredentialsRepository.updateBBApiCredentials(
          database: any(named: 'database'),
          id: any(named: 'id'),
          applicationDeveloperKey: any(named: 'applicationDeveloperKey'),
          basicKey: any(named: 'basicKey'),
          isFavorite: any(named: 'isFavorite'),
        ),
      ).thenAnswer((_) async => Failure(apiCredentialsError));

      final response = await updateBBApiCredentialsUseCase(
        database: database,
        id: 'userID',
        bbApiCredentialsEntity: bbApiCredentialsEntity,
      );

      expect(response.isError(), true);

      verify(
        () => apiCredentialsRepository.updateBBApiCredentials(
          database: database,
          id: 'userID',
          applicationDeveloperKey:
              bbApiCredentialsEntity.applicationDeveloperKey,
          basicKey: bbApiCredentialsEntity.basicKey,
          isFavorite: bbApiCredentialsEntity.isFavorite,
        ),
      ).called(1);

      final result = response.exceptionOrNull();

      expect(result, isNotNull);
      expect(result!.message, equals('Error Saving Credentials'));
    });
  });
}
