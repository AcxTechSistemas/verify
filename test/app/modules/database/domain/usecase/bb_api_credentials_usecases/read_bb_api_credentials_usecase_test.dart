import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/modules/database/domain/repository/api_credentials_repository.dart';
import 'package:verify/app/modules/database/domain/usecase/bb_api_credentials_usecases/read_bb_api_credentials_usecase.dart';

class MockApiCredentialsRepository extends Mock
    implements ApiCredentialsRepository {}

void main() {
  late ReadBBApiCredentialsUseCase readBBApiCredentialsUseCase;
  late ApiCredentialsRepository apiCredentialsRepository;
  late BBApiCredentialsEntity bbApiCredentialsEntity;

  setUp(() {
    apiCredentialsRepository = MockApiCredentialsRepository();
    readBBApiCredentialsUseCase = ReadBBApiCredentialsUseCaseImpl(
      apiCredentialsRepository,
    );
    bbApiCredentialsEntity = BBApiCredentialsEntity(
      applicationDeveloperKey: 'teste',
      basicKey: 'teste',
      isFavorite: false,
    );
    registerFallbackValue(bbApiCredentialsEntity);
  });

  group('ReadBBApiCredentialsUseCase: ', () {
    test('Should return success on readBBApiCredentials', () async {
      when(() => apiCredentialsRepository.readBBApiCredentials(
            id: any(named: 'id'),
          )).thenAnswer((_) async => Success(bbApiCredentialsEntity));

      final response = await readBBApiCredentialsUseCase(
        id: 'userID',
      );
      final result = response.getOrNull();
      expect(result, isNotNull);
      expect(result!.applicationDeveloperKey, equals('teste'));
    });

    test(
        'Should return ErrorReadingApiCredentials on readBBApiCredentialsUseCase',
        () async {
      final apiCredentialsError = ErrorReadingApiCredentials(
        message: 'Error Reading Credentials',
      );

      when(
        () =>
            apiCredentialsRepository.readBBApiCredentials(id: any(named: 'id')),
      ).thenAnswer((_) async => Failure(apiCredentialsError));

      final response = await readBBApiCredentialsUseCase(
        id: 'userID',
      );

      expect(response.isError(), true);

      final result = response.exceptionOrNull();

      expect(result, isNotNull);
      expect(result!.message, equals('Error Reading Credentials'));
    });
  });
}
