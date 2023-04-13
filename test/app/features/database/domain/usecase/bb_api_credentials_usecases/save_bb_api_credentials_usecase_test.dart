import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/features/database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/features/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/features/database/domain/repository/api_credentials_repository.dart';
import 'package:verify/app/features/database/domain/usecase/bb_api_credentials_usecases/save_bb_api_credentials_usecase.dart';

class MockApiCredentialsRepository extends Mock
    implements ApiCredentialsRepository {}

void main() {
  late SaveBBApiCredentialsUseCase saveBBApiCredentialsUseCase;
  late ApiCredentialsRepository apiCredentialsRepository;
  late BBApiCredentialsEntity bbApiCredentialsEntity;

  setUp(() {
    apiCredentialsRepository = MockApiCredentialsRepository();
    saveBBApiCredentialsUseCase = SaveBBApiCredentialsUseCaseImpl(
      apiCredentialsRepository,
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
      when(() => apiCredentialsRepository.saveBBApiCredentials(
            id: any(named: 'id'),
            bbApiCredentialsEntity: any(named: 'bbApiCredentialsEntity'),
          )).thenAnswer((_) async => const Success(Void));

      final response = await saveBBApiCredentialsUseCase(
        id: 'userID',
        bbApiCredentialsEntity: bbApiCredentialsEntity,
      );

      verify(() => apiCredentialsRepository.saveBBApiCredentials(
              id: any(named: 'id'),
              bbApiCredentialsEntity: any(named: 'bbApiCredentialsEntity')))
          .called(1);

      expect(response.isSuccess(), true);
    });

    test('Should return ApiCredentialsError on failure', () async {
      final apiCredentialsError = ErrorSavingApiCredentials(
        message: 'Error Saving Credentials',
      );

      when(
        () => apiCredentialsRepository.saveBBApiCredentials(
            id: any(named: 'id'),
            bbApiCredentialsEntity: any(named: 'bbApiCredentialsEntity')),
      ).thenAnswer((_) async => Failure(apiCredentialsError));

      final response = await saveBBApiCredentialsUseCase(
        id: 'userID',
        bbApiCredentialsEntity: bbApiCredentialsEntity,
      );

      expect(response.isError(), true);

      verify(() => apiCredentialsRepository.saveBBApiCredentials(
              id: any(named: 'id'),
              bbApiCredentialsEntity: any(named: 'bbApiCredentialsEntity')))
          .called(1);

      final result = response.exceptionOrNull();

      expect(result, isNotNull);
      expect(result!.message, equals('Error Saving Credentials'));
    });
  });
}
