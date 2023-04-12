import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/features/database/domain/entities/sicoob_api_credentials_entity.dart';
import 'package:verify/app/features/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/features/database/domain/repository/api_credentials_repository.dart';
import 'package:verify/app/features/database/domain/usecase/sicoob_api_credentials_usecases/save_sicoob_api_credentials_usecase.dart';

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
    test('Verify called saveSicoobApiCredentials and return Success', () async {
      when(() => apiCredentialsRepository.saveSicoobApiCredentials(
              sicoobApiCredentialsEntity:
                  any(named: 'sicoobApiCredentialsEntity')))
          .thenAnswer((_) async => const Success(Void));

      final response = await saveSicoobApiCredentialsUseCase(
        sicoobApiCredentialsEntity: sicoobApiCredentialsEntity,
      );

      expect(response.isSuccess(), true);

      verify(() => apiCredentialsRepository.saveSicoobApiCredentials(
          sicoobApiCredentialsEntity:
              any(named: 'sicoobApiCredentialsEntity'))).called(1);
    });

    test('Should return ApiCredentialsError on failure', () async {
      final apiCredentialsError = ErrorSavingApiCredentials(
        message: 'Error Saving Credentials',
      );

      when(() => apiCredentialsRepository.saveSicoobApiCredentials(
              sicoobApiCredentialsEntity:
                  any(named: 'sicoobApiCredentialsEntity')))
          .thenAnswer((_) async => Failure(apiCredentialsError));

      final response = await saveSicoobApiCredentialsUseCase(
        sicoobApiCredentialsEntity: sicoobApiCredentialsEntity,
      );

      expect(response.isError(), true);

      verify(() => apiCredentialsRepository.saveSicoobApiCredentials(
          sicoobApiCredentialsEntity:
              any(named: 'sicoobApiCredentialsEntity'))).called(1);

      final result = response.exceptionOrNull();

      expect(result, isNotNull);
      expect(result!.message, equals('Error Saving Credentials'));
    });
  });
}
