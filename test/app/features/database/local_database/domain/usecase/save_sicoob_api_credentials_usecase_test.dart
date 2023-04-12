import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/features/database/local_database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/features/database/local_database/domain/repository/local_database_repository.dart';
import 'package:verify/app/features/database/local_database/domain/usecase/save_sicoob_api_credentials_usecase.dart';

class MockLocalDataBaseRepository extends Mock
    implements LocalDataBaseRepository {}

void main() {
  late SaveSicoobApiCredentialsUseCase saveSicoobApiCredentialsUseCase;
  late LocalDataBaseRepository localDataBaseRepository;

  setUp(() {
    localDataBaseRepository = MockLocalDataBaseRepository();
    saveSicoobApiCredentialsUseCase = SaveSicoobApiCredentialsUseCaseImpl(
      localDataBaseRepository,
    );
  });

  group('SaveSicoobApiCredentialsUseCase: ', () {
    test('Verify called saveSicoobApiCredentials and return void', () async {
      when(() => localDataBaseRepository.saveSicoobApiCredentials())
          .thenAnswer((_) async => const Success(Void));

      final response = await saveSicoobApiCredentialsUseCase();

      verify(() => localDataBaseRepository.saveSicoobApiCredentials())
          .called(1);

      expect(response.isSuccess(), true);
    });

    test('Should return ApiCredentialsError on failure', () async {
      final apiCredentialsError = ErrorSavingApiCredentials(
        message: 'Error Saving Credentials',
      );

      when(() => localDataBaseRepository.saveSicoobApiCredentials())
          .thenAnswer((_) async => Failure(apiCredentialsError));

      final response = await saveSicoobApiCredentialsUseCase();

      expect(response.isError(), true);

      verify(() => localDataBaseRepository.saveSicoobApiCredentials())
          .called(1);

      final result = response.exceptionOrNull();

      expect(result, isNotNull);
      expect(result!.message, equals('Error Saving Credentials'));
    });
  });
}
