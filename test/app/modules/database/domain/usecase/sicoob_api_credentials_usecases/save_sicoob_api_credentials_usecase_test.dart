import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/database/domain/entities/sicoob_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/modules/database/domain/repository/api_credentials_repository.dart';
import 'package:verify/app/modules/database/domain/usecase/sicoob_api_credentials_usecases/save_sicoob_api_credentials_usecase.dart';

class MockApiCredentialsRepository extends Mock
    implements ApiCredentialsRepository {}

void main() {
  late SaveSicoobApiCredentialsUseCase saveSicoobApiCredentialsUseCase;
  late ApiCredentialsRepository apiCredentialsRepository;
  late SicoobApiCredentialsEntity sicoobApiCredentialsEntity;

  setUp(() {
    apiCredentialsRepository = MockApiCredentialsRepository();
    saveSicoobApiCredentialsUseCase = SaveSicoobApiCredentialsUseCaseImpl(
      apiCredentialsRepository,
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
    test('Should return success on saveSicoobApiCredentials', () async {
      when(
        () => apiCredentialsRepository.saveSicoobApiCredentials(
          id: any(named: 'id'),
          clientID: any(named: 'clientID'),
          certificateBase64String: any(named: 'certificateBase64String'),
          certificatePassword: any(named: 'certificatePassword'),
          isFavorite: any(named: 'isFavorite'),
        ),
      ).thenAnswer((_) async => const Success(Void));

      final response = await saveSicoobApiCredentialsUseCase(
        id: 'userID',
        sicoobApiCredentialsEntity: sicoobApiCredentialsEntity,
      );

      expect(response.isSuccess(), true);

      verify(
        () => apiCredentialsRepository.saveSicoobApiCredentials(
          id: 'userID',
          clientID: sicoobApiCredentialsEntity.clientID,
          certificateBase64String:
              sicoobApiCredentialsEntity.certificateBase64String,
          certificatePassword: sicoobApiCredentialsEntity.certificatePassword,
          isFavorite: sicoobApiCredentialsEntity.isFavorite,
        ),
      ).called(1);
    });

    test('Should return ApiCredentialsError on saveSicoobApiCredentials',
        () async {
      final apiCredentialsError = ErrorSavingApiCredentials(
        message: 'Error Saving Credentials',
      );

      when(
        () => apiCredentialsRepository.saveSicoobApiCredentials(
          id: any(named: 'id'),
          clientID: any(named: 'clientID'),
          certificateBase64String: any(named: 'certificateBase64String'),
          certificatePassword: any(named: 'certificatePassword'),
          isFavorite: any(named: 'isFavorite'),
        ),
      ).thenAnswer((_) async => Failure(apiCredentialsError));

      final response = await saveSicoobApiCredentialsUseCase(
        id: 'userID',
        sicoobApiCredentialsEntity: sicoobApiCredentialsEntity,
      );

      expect(response.isError(), true);

      verify(
        () => apiCredentialsRepository.saveSicoobApiCredentials(
          id: 'userID',
          clientID: sicoobApiCredentialsEntity.clientID,
          certificateBase64String:
              sicoobApiCredentialsEntity.certificateBase64String,
          certificatePassword: sicoobApiCredentialsEntity.certificatePassword,
          isFavorite: sicoobApiCredentialsEntity.isFavorite,
        ),
      ).called(1);

      final result = response.exceptionOrNull();

      expect(result, isNotNull);
      expect(result!.message, equals('Error Saving Credentials'));
    });
  });
}
