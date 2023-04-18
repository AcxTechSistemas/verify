import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/modules/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/modules/database/domain/repository/api_credentials_repository.dart';
import 'package:verify/app/modules/database/domain/usecase/bb_api_credentials_usecases/remove_bb_api_credentials_usecase.dart';
import 'package:verify/app/modules/database/utils/database_enums.dart';

class MockApiCredentialsRepository extends Mock
    implements ApiCredentialsRepository {}

void main() {
  late RemoveBBApiCredentialsUseCase removeBBApiCredentialsUseCase;
  late ApiCredentialsRepository apiCredentialsRepository;
  late BBApiCredentialsEntity bbApiCredentialsEntity;
  late Database database;

  setUp(() {
    apiCredentialsRepository = MockApiCredentialsRepository();
    removeBBApiCredentialsUseCase = RemoveBBApiCredentialsUseCaseImpl(
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

  group('RemoveBBApiCredentialsUseCase: ', () {
    test('Should return success on removeBBApiCredentials', () async {
      when(() => apiCredentialsRepository.removeBBApiCredentials(
            database: any(named: 'database'),
            id: any(named: 'id'),
          )).thenAnswer((_) async => const Success(Void));

      final response = await removeBBApiCredentialsUseCase(
        database: database,
        id: 'userID',
      );

      verify(() => apiCredentialsRepository.removeBBApiCredentials(
            database: any(named: 'database'),
            id: any(named: 'id'),
          )).called(1);

      expect(response.isSuccess(), true);
    });

    test('Should return ErrorRemovingApiCredentials on removeBBApiCredentials',
        () async {
      final apiCredentialsError = ErrorRemovingApiCredentials(
        message: 'Error Removing Credentials',
      );

      when(
        () => apiCredentialsRepository.removeBBApiCredentials(
          database: any(named: 'database'),
          id: any(named: 'id'),
        ),
      ).thenAnswer((_) async => Failure(apiCredentialsError));

      final response = await removeBBApiCredentialsUseCase(
        database: database,
        id: 'userID',
      );

      final result = response.exceptionOrNull();

      expect(result, isNotNull);
      expect(result!.message, equals('Error Removing Credentials'));
    });
  });
}
