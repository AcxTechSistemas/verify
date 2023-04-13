import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:verify/app/features/database/domain/repository/api_credentials_repository.dart';
import 'package:verify/app/features/database/infra/datasource/api_credentials_datasource.dart';
import 'package:verify/app/features/database/infra/models/bb_api_credentials_model.dart';
import 'package:verify/app/features/database/infra/models/sicoob_api_credentials_model.dart';
import 'package:verify/app/features/database/infra/repository/api_credentials_repository_impl.dart';

class MockApiCredentialsDataSource extends Mock
    implements ApiCredentialsDataSource {}

class MockBBApiCredentialsModel extends Mock implements BBApiCredentialsModel {}

class MockSicoobApiCredentialsModel extends Mock
    implements SicoobApiCredentialsModel {}

void main() {
  late ApiCredentialsDataSource apiCredentialsDataSource;
  late ApiCredentialsRepository apiCredentialsRepository;
  late BBApiCredentialsModel bbApiCredentialsModel;
  late SicoobApiCredentialsModel sicoobApiCredentialsModel;

  setUp(() {
    apiCredentialsDataSource = MockApiCredentialsDataSource();
    apiCredentialsRepository = ApiCredentialsRepositoryImpl(
      apiCredentialsDataSource,
    );
    bbApiCredentialsModel = MockBBApiCredentialsModel();
    sicoobApiCredentialsModel = MockSicoobApiCredentialsModel();

    registerFallbackValue(bbApiCredentialsModel);
    registerFallbackValue(sicoobApiCredentialsModel);
  });

  group('ApiCredentialsRepositoryImpl: ', () {
    group('Banco do Brasil: ', () {
      test('Should return BBApiCredentialsEntity on readBBApiCredentials',
          () async {
        when(() => bbApiCredentialsModel.applicationDeveloperKey).thenReturn(
          'testeAppDevKey',
        );
        when(() => apiCredentialsDataSource.readBBApiCredentials()).thenAnswer(
          (_) async => bbApiCredentialsModel,
        );
        final response = await apiCredentialsRepository.readBBApiCredentials();

        expect(response.isSuccess(), true);

        final result = response.getOrNull();
        expect(result, isNotNull);
        expect(result!.applicationDeveloperKey, equals('testeAppDevKey'));
      });

      test('Should return ErrorReadingApiCredentials on readBBApiCredentials',
          () async {
        when(() => apiCredentialsDataSource.readBBApiCredentials()).thenThrow(
          Exception(),
        );
        const expectedResponse =
            'Ocorreu um erro ao recuperar as credenciais do Banco do Brasil';
        final response = await apiCredentialsRepository.readBBApiCredentials();
        final result = response.exceptionOrNull();
        expect(result, isNotNull);
        expect(result!.message, equals(expectedResponse));
      });

      test('Should return Success on deleteBBApiCredentials', () async {
        when(() => apiCredentialsDataSource.deleteBBApiCredentials())
            .thenAnswer((_) async => {});

        final response =
            await apiCredentialsRepository.removeBBApiCredentials();

        verify(() => apiCredentialsDataSource.deleteBBApiCredentials())
            .called(1);

        expect(response.isSuccess(), true);
      });

      test(
          'Should return ErrorRemovingApiCredentials on deleteBBApiCredentials',
          () async {
        when(() => apiCredentialsDataSource.deleteBBApiCredentials()).thenThrow(
          Exception(),
        );
        const expectedResponse =
            'Ocorreu um erro ao remover as credenciais do Banco do Brasil';
        final response =
            await apiCredentialsRepository.removeBBApiCredentials();
        final result = response.exceptionOrNull();
        expect(result, isNotNull);
        expect(result!.message, equals(expectedResponse));
      });
      test('Should return success on saveBBApiCredentials', () async {
        when(() => apiCredentialsDataSource.saveBBApiCredentials(
                bbApiCredentialsEntity: any(named: 'bbApiCredentialsEntity')))
            .thenAnswer((_) async {});

        final response = await apiCredentialsRepository.saveBBApiCredentials(
          bbApiCredentialsEntity: bbApiCredentialsModel,
        );

        verify(() => apiCredentialsDataSource.saveBBApiCredentials(
            bbApiCredentialsEntity: any(named: 'bbApiCredentialsEntity')));

        expect(response.isSuccess(), true);
      });

      test('Should return ErrorSavingApiCredentials on saveBBApiCredentials',
          () async {
        when(() => apiCredentialsDataSource.saveBBApiCredentials(
                bbApiCredentialsEntity: any(named: 'bbApiCredentialsEntity')))
            .thenThrow(Exception());
        const expectedResponse =
            'Ocorreu um erro ao salvar as credenciais do Banco do Brasil';
        final response = await apiCredentialsRepository.saveBBApiCredentials(
          bbApiCredentialsEntity: bbApiCredentialsModel,
        );

        final result = response.exceptionOrNull();
        expect(result, isNotNull);
        expect(result!.message, equals(expectedResponse));
      });

      test('Should return success on updateBBApiCredentials', () async {
        when(
          () => apiCredentialsDataSource.updateBBApiCredentials(
              bbApiCredentialsEntity: any(named: 'bbApiCredentialsEntity')),
        ).thenAnswer((_) async {});

        final response = await apiCredentialsRepository.updateBBApiCredentials(
          bbApiCredentialsEntity: bbApiCredentialsModel,
        );
        verify(() => apiCredentialsDataSource.updateBBApiCredentials(
            bbApiCredentialsEntity: any(named: 'bbApiCredentialsEntity')));

        expect(response.isSuccess(), true);
      });
      test('Should return ErrorUpdateApiCredentials on updateBBApiCredentials',
          () async {
        when(
          () => apiCredentialsDataSource.updateBBApiCredentials(
              bbApiCredentialsEntity: any(named: 'bbApiCredentialsEntity')),
        ).thenThrow(Exception());
        const expectedResponse =
            'Ocorreu um erro ao atualizar as credenciais do Banco do Brasil';

        final response = await apiCredentialsRepository.updateBBApiCredentials(
          bbApiCredentialsEntity: bbApiCredentialsModel,
        );

        final result = response.exceptionOrNull();
        expect(result, isNotNull);
        expect(result!.message, equals(expectedResponse));
      });
    });

    group('Sicoob: ', () {
      test(
          'Should return SicoobApiCredentialsEntity on readSicoobApiCredentials',
          () async {
        when(() => sicoobApiCredentialsModel.clientID).thenReturn(
          'testeClientID',
        );
        when(() => apiCredentialsDataSource.readSicoobApiCredentials())
            .thenAnswer(
          (_) async => sicoobApiCredentialsModel,
        );
        final response =
            await apiCredentialsRepository.readSicoobApiCredentials();

        expect(response.isSuccess(), true);

        final result = response.getOrNull();
        expect(result, isNotNull);
        expect(result!.clientID, equals('testeClientID'));
      });
      test(
          'Should return ErrorReadingApiCredentials on readSicoobApiCredentials',
          () async {
        when(() => apiCredentialsDataSource.readSicoobApiCredentials())
            .thenThrow(
          Exception('Error'),
        );
        const expectedResponse =
            'Ocorreu um erro ao recuperar as credenciais do Sicoob';
        final response =
            await apiCredentialsRepository.readSicoobApiCredentials();

        final result = response.exceptionOrNull();
        expect(result, isNotNull);
        expect(result!.message, equals(expectedResponse));
      });
      test('Should return Success on deleteSicoobApiCredentials', () async {
        when(() => apiCredentialsDataSource.deleteSicoobApiCredentials())
            .thenAnswer((_) async => {});

        final response =
            await apiCredentialsRepository.removeSicoobApiCredentials();

        verify(() => apiCredentialsDataSource.deleteSicoobApiCredentials())
            .called(1);

        expect(response.isSuccess(), true);
      });
      test(
          'Should return ErrorRemovingApiCredentials on deleteSicoobApiCredentials',
          () async {
        when(() => apiCredentialsDataSource.deleteSicoobApiCredentials())
            .thenThrow(Exception());
        const expectedResponse =
            'Ocorreu um erro ao remover as credenciais do Sicoob';
        final response =
            await apiCredentialsRepository.removeSicoobApiCredentials();
        final result = response.exceptionOrNull();
        expect(result, isNotNull);
        expect(result!.message, equals(expectedResponse));
      });
      test('Should return success on saveSicoobApiCredentials', () async {
        when(
          () => apiCredentialsDataSource.saveSicoobApiCredentials(
              sicoobApiCredentialsEntity:
                  any(named: 'sicoobApiCredentialsEntity')),
        ).thenAnswer((_) async {});

        final response =
            await apiCredentialsRepository.saveSicoobApiCredentials(
          sicoobApiCredentialsEntity: sicoobApiCredentialsModel,
        );

        verify(() => apiCredentialsDataSource.saveSicoobApiCredentials(
            sicoobApiCredentialsEntity:
                any(named: 'sicoobApiCredentialsEntity')));

        expect(response.isSuccess(), true);
      });

      test(
          'Should return ErrorSavingApiCredentials on saveSicoobApiCredentials',
          () async {
        when(
          () => apiCredentialsDataSource.saveSicoobApiCredentials(
              sicoobApiCredentialsEntity:
                  any(named: 'sicoobApiCredentialsEntity')),
        ).thenThrow(Exception());
        const expectedResponse =
            'Ocorreu um erro ao salvar as credenciais do Sicoob';
        final response =
            await apiCredentialsRepository.saveSicoobApiCredentials(
          sicoobApiCredentialsEntity: sicoobApiCredentialsModel,
        );

        final result = response.exceptionOrNull();
        expect(result, isNotNull);
        expect(result!.message, equals(expectedResponse));
      });
      test('Should return success on updateSicoobApiCredentials', () async {
        when(
          () => apiCredentialsDataSource.updateSicoobApiCredentials(
              sicoobApiCredentialsEntity:
                  any(named: 'sicoobApiCredentialsEntity')),
        ).thenAnswer((_) async {});

        final response =
            await apiCredentialsRepository.updateSicoobApiCredentials(
          sicoobApiCredentialsEntity: sicoobApiCredentialsModel,
        );
        verify(() => apiCredentialsDataSource.updateSicoobApiCredentials(
            sicoobApiCredentialsEntity:
                any(named: 'sicoobApiCredentialsEntity')));

        expect(response.isSuccess(), true);
      });
      test('Should return ErrorUpdateApiCredentials on updateBBApiCredentials',
          () async {
        when(
          () => apiCredentialsDataSource.updateSicoobApiCredentials(
              sicoobApiCredentialsEntity:
                  any(named: 'sicoobApiCredentialsEntity')),
        ).thenThrow(Exception());
        const expectedResponse =
            'Ocorreu um erro ao atualizar as credenciais do Sicoob';

        final response =
            await apiCredentialsRepository.updateSicoobApiCredentials(
          sicoobApiCredentialsEntity: sicoobApiCredentialsModel,
        );

        final result = response.exceptionOrNull();
        expect(result, isNotNull);
        expect(result!.message, equals(expectedResponse));
      });
    });
  });
}
