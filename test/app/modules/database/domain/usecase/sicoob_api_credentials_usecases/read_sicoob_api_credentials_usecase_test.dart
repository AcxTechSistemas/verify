import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/database/domain/entities/sicoob_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/modules/database/domain/repository/api_credentials_repository.dart';
import 'package:verify/app/modules/database/domain/usecase/sicoob_api_credentials_usecases/read_sicoob_api_credentials_usecase.dart';

class MockApiCredentialsRepository extends Mock
    implements ApiCredentialsRepository {}

void main() {
  late ReadSicoobApiCredentialsUseCase readSicoobApiCredentialsUseCase;
  late ApiCredentialsRepository apiCredentialsRepository;
  late SicoobApiCredentialsEntity sicoobApiCredentialsEntity;

  setUp(() {
    apiCredentialsRepository = MockApiCredentialsRepository();
    readSicoobApiCredentialsUseCase = ReadSicoobApiCredentialsUseCaseImpl(
      apiCredentialsRepository,
    );
    sicoobApiCredentialsEntity = SicoobApiCredentialsEntity(
      clientID: 'clientID',
      certificateBase64String: 'certString',
      certificatePassword: 'certPassword',
      isFavorite: false,
    );
    registerFallbackValue(sicoobApiCredentialsEntity);
  });

  group('ReadSicoobApiCredentialsUseCase: ', () {
    test('Should return success on readSicoobApiCredentials', () async {
      when(() => apiCredentialsRepository.readSicoobApiCredentials(
            id: any(named: 'id'),
          )).thenAnswer((_) async => Success(sicoobApiCredentialsEntity));

      final response = await readSicoobApiCredentialsUseCase(
        id: 'userID',
      );
      final result = response.getOrNull();
      expect(result, isNotNull);
      expect(result!.clientID, equals('clientID'));
    });

    test('Should return ErrorReadingApiCredentials on readSicoobApiCredentials',
        () async {
      final apiCredentialsError = ErrorReadingApiCredentials(
        message: 'Error Reading Credentials',
      );

      when(
        () => apiCredentialsRepository.readSicoobApiCredentials(
            id: any(named: 'id')),
      ).thenAnswer((_) async => Failure(apiCredentialsError));

      final response = await readSicoobApiCredentialsUseCase(
        id: 'userID',
      );

      expect(response.isError(), true);

      final result = response.exceptionOrNull();

      expect(result, isNotNull);
      expect(result!.message, equals('Error Reading Credentials'));
    });
  });
}
