import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/features/database/local_database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/features/database/local_database/domain/repository/local_database_repository.dart';
import 'package:verify/app/features/database/local_database/domain/usecase/save_bb_api_credentials_usecase.dart';

class MockLocalDataBaseRepository extends Mock
    implements LocalDataBaseRepository {}

void main() {
  late SaveBBApiCredentialsUseCase saveBBApiCredentialsUseCase;
  late LocalDataBaseRepository localDataBaseRepository;

  setUp(() {
    localDataBaseRepository = MockLocalDataBaseRepository();
    saveBBApiCredentialsUseCase = SaveBBApiCredentialsUseCaseImpl(
      localDataBaseRepository,
    );
  });

  group('SaveBBApiCredentialsUseCase: ', () {
    test('Verify called saveBBApiCredentials and return void', () async {
      when(() => localDataBaseRepository.saveBBApiCredentials())
          .thenAnswer((_) async => const Success(Void));

      final response = await saveBBApiCredentialsUseCase();

      verify(() => localDataBaseRepository.saveBBApiCredentials()).called(1);

      expect(response.isSuccess(), true);
    });

    test('Should return ApiCredentialsError on failure', () async {
      final apiCredentialsError = ErrorSavingApiCredentials(
        message: 'Error Saving Credentials',
      );

      when(() => localDataBaseRepository.saveBBApiCredentials())
          .thenAnswer((_) async => Failure(apiCredentialsError));

      final response = await saveBBApiCredentialsUseCase();

      expect(response.isError(), true);

      verify(() => localDataBaseRepository.saveBBApiCredentials()).called(1);

      final result = response.exceptionOrNull();

      expect(result, isNotNull);
      expect(result!.message, equals('Error Saving Credentials'));
    });
  });
}
