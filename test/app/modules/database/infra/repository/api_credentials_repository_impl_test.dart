import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:verify/app/modules/database/domain/repository/api_credentials_repository.dart';
import 'package:verify/app/modules/database/infra/datasource/cloud_api_credentials_datasource.dart';
import 'package:verify/app/modules/database/infra/datasource/local_api_credentials_datasource.dart';
import 'package:verify/app/modules/database/infra/models/bb_api_credentials_model.dart';
import 'package:verify/app/modules/database/infra/models/sicoob_api_credentials_model.dart';
import 'package:verify/app/modules/database/infra/repository/api_credentials_repository_impl.dart';
import 'package:verify/app/modules/database/utils/database_enums.dart';

class MockCloudApiCredentialsDataSource extends Mock
    implements CloudApiCredentialsDataSource {}

class MockLocalApiCredentialsDataSource extends Mock
    implements LocalApiCredentialsDataSource {}

class MockBBApiCredentialsModel extends Mock implements BBApiCredentialsModel {}

class MockSicoobApiCredentialsModel extends Mock
    implements SicoobApiCredentialsModel {}

void main() {
  late CloudApiCredentialsDataSource cloudApiCredentialsDataSource;
  late LocalApiCredentialsDataSource localApiCredentialsDataSource;
  late ApiCredentialsRepository apiCredentialsRepository;
  late BBApiCredentialsModel bbApiCredentialsModel;
  late SicoobApiCredentialsModel sicoobApiCredentialsModel;
  late Database database;

  setUp(() {
    cloudApiCredentialsDataSource = MockCloudApiCredentialsDataSource();
    localApiCredentialsDataSource = MockLocalApiCredentialsDataSource();
    apiCredentialsRepository = ApiCredentialsRepositoryImpl(
      cloudApiCredentialsDataSource,
      localApiCredentialsDataSource,
    );
    bbApiCredentialsModel = MockBBApiCredentialsModel();
    sicoobApiCredentialsModel = MockSicoobApiCredentialsModel();

    database = Database.local;
    registerFallbackValue(database);
    registerFallbackValue(bbApiCredentialsModel);
    registerFallbackValue(sicoobApiCredentialsModel);
  });

  group('ApiCredentialsRepositoryImpl: ', () {
    group('Banco do Brasil: ', () {
      test('Should switch DataSource to cloud', () async {
        database = Database.cloud;
        when(() => cloudApiCredentialsDataSource.readBBApiCredentials(
              id: any(named: 'id'),
            )).thenAnswer((_) async => bbApiCredentialsModel);

        final response = await apiCredentialsRepository.readBBApiCredentials(
          database: database,
          id: 'id',
        );

        final result = response.getOrNull();
        expect(result, isNotNull);
      });
      test('Should return BBApiCredentialsEntity on readBBApiCredentials',
          () async {
        when(() => bbApiCredentialsModel.applicationDeveloperKey).thenReturn(
          'testeAppDevKey',
        );
        when(() => localApiCredentialsDataSource.readBBApiCredentials(
              id: any(named: 'id'),
            )).thenAnswer((_) async => bbApiCredentialsModel);

        final response = await apiCredentialsRepository.readBBApiCredentials(
          database: database,
          id: 'userID',
        );

        expect(response.isSuccess(), true);

        final result = response.getOrNull();
        expect(result, isNotNull);
        expect(result!.applicationDeveloperKey, equals('testeAppDevKey'));
      });

      test('Should return ErrorReadingApiCredentials on readBBApiCredentials',
          () async {
        when(() => localApiCredentialsDataSource.readBBApiCredentials(
              id: any(named: 'id'),
            )).thenThrow(
          Exception(),
        );
        const expectedResponse =
            'Ocorreu um erro ao recuperar as credenciais do Banco do Brasil';
        final response = await apiCredentialsRepository.readBBApiCredentials(
          database: database,
          id: 'userID',
        );
        final result = response.exceptionOrNull();
        expect(result, isNotNull);
        expect(result!.message, equals(expectedResponse));
      });

      test('Should return Success on deleteBBApiCredentials', () async {
        when(() => localApiCredentialsDataSource.deleteBBApiCredentials(
              id: any(named: 'id'),
            )).thenAnswer((_) async => {});

        final response = await apiCredentialsRepository.removeBBApiCredentials(
          database: Database.local,
          id: 'userID',
        );

        verify(() => localApiCredentialsDataSource.deleteBBApiCredentials(
              id: any(named: 'id'),
            )).called(1);

        expect(response.isSuccess(), true);
      });

      test(
          'Should return ErrorRemovingApiCredentials on deleteBBApiCredentials',
          () async {
        when(() => localApiCredentialsDataSource.deleteBBApiCredentials(
              id: any(named: 'id'),
            )).thenThrow(
          Exception(),
        );
        const expectedResponse =
            'Ocorreu um erro ao remover as credenciais do Banco do Brasil';
        final response = await apiCredentialsRepository.removeBBApiCredentials(
          database: database,
          id: 'userID',
        );
        final result = response.exceptionOrNull();
        expect(result, isNotNull);
        expect(result!.message, equals(expectedResponse));
      });
      test('Should return success on saveBBApiCredentials', () async {
        when(() => localApiCredentialsDataSource.saveBBApiCredentials(
              id: any(named: 'id'),
              applicationDeveloperKey: any(named: 'applicationDeveloperKey'),
              basicKey: any(named: 'basicKey'),
              isFavorite: any(named: 'isFavorite'),
            )).thenAnswer((_) async {});

        final response = await apiCredentialsRepository.saveBBApiCredentials(
          database: Database.local,
          id: 'userID',
          applicationDeveloperKey: 'applicationDeveloperKey',
          basicKey: 'basicKey',
          isFavorite: false,
        );

        verify(() => localApiCredentialsDataSource.saveBBApiCredentials(
              id: any(named: 'id'),
              applicationDeveloperKey: any(named: 'applicationDeveloperKey'),
              basicKey: any(named: 'basicKey'),
              isFavorite: any(named: 'isFavorite'),
            ));

        expect(response.isSuccess(), true);
      });

      test('Should return ErrorSavingApiCredentials on saveBBApiCredentials',
          () async {
        when(() => localApiCredentialsDataSource.saveBBApiCredentials(
              id: any(named: 'id'),
              applicationDeveloperKey: any(named: 'applicationDeveloperKey'),
              basicKey: any(named: 'basicKey'),
              isFavorite: any(named: 'isFavorite'),
            )).thenThrow(Exception());
        const expectedResponse =
            'Ocorreu um erro ao salvar as credenciais do Banco do Brasil';
        final response = await apiCredentialsRepository.saveBBApiCredentials(
          database: Database.local,
          id: 'userID',
          applicationDeveloperKey: 'applicationDeveloperKey',
          basicKey: 'basicKey',
          isFavorite: false,
        );

        final result = response.exceptionOrNull();
        expect(result, isNotNull);
        expect(result!.message, equals(expectedResponse));
      });

      test('Should return success on updateBBApiCredentials', () async {
        when(
          () => localApiCredentialsDataSource.updateBBApiCredentials(
            id: any(named: 'id'),
            applicationDeveloperKey: any(named: 'applicationDeveloperKey'),
            basicKey: any(named: 'basicKey'),
            isFavorite: any(named: 'isFavorite'),
          ),
        ).thenAnswer((_) async {});

        final response = await apiCredentialsRepository.updateBBApiCredentials(
          database: database,
          id: 'userID',
          applicationDeveloperKey: 'applicationDeveloperKey',
          basicKey: 'basicKey',
          isFavorite: false,
        );
        verify(() => localApiCredentialsDataSource.updateBBApiCredentials(
              id: any(named: 'id'),
              applicationDeveloperKey: any(named: 'applicationDeveloperKey'),
              basicKey: any(named: 'basicKey'),
              isFavorite: any(named: 'isFavorite'),
            ));

        expect(response.isSuccess(), true);
      });
      test('Should return ErrorUpdateApiCredentials on updateBBApiCredentials',
          () async {
        when(
          () => localApiCredentialsDataSource.updateBBApiCredentials(
            id: any(named: 'id'),
            applicationDeveloperKey: any(named: 'applicationDeveloperKey'),
            basicKey: any(named: 'basicKey'),
            isFavorite: any(named: 'isFavorite'),
          ),
        ).thenThrow(Exception());
        const expectedResponse =
            'Ocorreu um erro ao atualizar as credenciais do Banco do Brasil';

        final response = await apiCredentialsRepository.updateBBApiCredentials(
          database: Database.local,
          id: 'userID',
          applicationDeveloperKey: 'applicationDeveloperKey',
          basicKey: 'basicKey',
          isFavorite: false,
        );

        final result = response.exceptionOrNull();
        expect(result, isNotNull);
        expect(result!.message, equals(expectedResponse));
      });
    });

    group('Sicoob: ', () {
      test('Should switch DataSource to cloud', () async {
        database = Database.cloud;
        when(() => cloudApiCredentialsDataSource.readSicoobApiCredentials(
              id: any(named: 'id'),
            )).thenAnswer((_) async => sicoobApiCredentialsModel);

        final response =
            await apiCredentialsRepository.readSicoobApiCredentials(
          database: database,
          id: 'id',
        );

        final result = response.getOrNull();
        expect(result, isNotNull);
      });
      test(
          'Should return SicoobApiCredentialsEntity on readSicoobApiCredentials',
          () async {
        when(() => sicoobApiCredentialsModel.clientID).thenReturn(
          'testeClientID',
        );
        when(() => localApiCredentialsDataSource.readSicoobApiCredentials(
              id: any(named: 'id'),
            )).thenAnswer(
          (_) async => sicoobApiCredentialsModel,
        );
        final response =
            await apiCredentialsRepository.readSicoobApiCredentials(
          database: database,
          id: 'userID',
        );

        expect(response.isSuccess(), true);

        final result = response.getOrNull();
        expect(result, isNotNull);
        expect(result!.clientID, equals('testeClientID'));
      });
      test(
          'Should return ErrorReadingApiCredentials on readSicoobApiCredentials',
          () async {
        when(() => localApiCredentialsDataSource.readSicoobApiCredentials(
              id: any(named: 'id'),
            )).thenThrow(
          Exception('Error'),
        );
        const expectedResponse =
            'Ocorreu um erro ao recuperar as credenciais do Sicoob';
        final response =
            await apiCredentialsRepository.readSicoobApiCredentials(
          database: database,
          id: 'userID',
        );

        final result = response.exceptionOrNull();
        expect(result, isNotNull);
        expect(result!.message, equals(expectedResponse));
      });
      test('Should return Success on deleteSicoobApiCredentials', () async {
        when(() => localApiCredentialsDataSource.deleteSicoobApiCredentials(
              id: any(named: 'id'),
            )).thenAnswer((_) async => {});

        final response =
            await apiCredentialsRepository.removeSicoobApiCredentials(
          database: database,
          id: 'userID',
        );

        verify(() => localApiCredentialsDataSource.deleteSicoobApiCredentials(
              id: any(named: 'id'),
            )).called(1);

        expect(response.isSuccess(), true);
      });
      test(
          'Should return ErrorRemovingApiCredentials on deleteSicoobApiCredentials',
          () async {
        when(() => localApiCredentialsDataSource.deleteSicoobApiCredentials(
              id: 'userID',
            )).thenThrow(Exception());
        const expectedResponse =
            'Ocorreu um erro ao remover as credenciais do Sicoob';
        final response =
            await apiCredentialsRepository.removeSicoobApiCredentials(
          database: database,
          id: 'userID',
        );
        final result = response.exceptionOrNull();
        expect(result, isNotNull);
        expect(result!.message, equals(expectedResponse));
      });
      test('Should return success on saveSicoobApiCredentials', () async {
        when(
          () => localApiCredentialsDataSource.saveSicoobApiCredentials(
            id: any(named: 'id'),
            clientID: any(named: 'clientID'),
            certificateBase64String: any(named: 'certificateBase64String'),
            certificatePassword: any(named: 'certificatePassword'),
            isFavorite: any(named: 'isFavorite'),
          ),
        ).thenAnswer((_) async {});

        final response =
            await apiCredentialsRepository.saveSicoobApiCredentials(
          database: database,
          id: 'userID',
          clientID: 'clientID',
          certificateBase64String: 'certificateBase64String',
          certificatePassword: 'certificatePassword',
          isFavorite: false,
        );

        verify(
          () => localApiCredentialsDataSource.saveSicoobApiCredentials(
            id: any(named: 'id'),
            clientID: any(named: 'clientID'),
            certificateBase64String: any(named: 'certificateBase64String'),
            certificatePassword: any(named: 'certificatePassword'),
            isFavorite: any(named: 'isFavorite'),
          ),
        );

        expect(response.isSuccess(), true);
      });

      test(
          'Should return ErrorSavingApiCredentials on saveSicoobApiCredentials',
          () async {
        when(
          () => localApiCredentialsDataSource.saveSicoobApiCredentials(
            id: any(named: 'id'),
            clientID: any(named: 'clientID'),
            certificateBase64String: any(named: 'certificateBase64String'),
            certificatePassword: any(named: 'certificatePassword'),
            isFavorite: any(named: 'isFavorite'),
          ),
        ).thenThrow(Exception());
        const expectedResponse =
            'Ocorreu um erro ao salvar as credenciais do Sicoob';
        final response =
            await apiCredentialsRepository.saveSicoobApiCredentials(
          database: database,
          id: 'userID',
          clientID: 'clientID',
          certificateBase64String: 'certificateBase64String',
          certificatePassword: 'certificatePassword',
          isFavorite: false,
        );

        final result = response.exceptionOrNull();
        expect(result, isNotNull);
        expect(result!.message, equals(expectedResponse));
      });
      test('Should return success on updateSicoobApiCredentials', () async {
        when(
          () => localApiCredentialsDataSource.updateSicoobApiCredentials(
            id: any(named: 'id'),
            clientID: any(named: 'clientID'),
            certificateBase64String: any(named: 'certificateBase64String'),
            certificatePassword: any(named: 'certificatePassword'),
            isFavorite: any(named: 'isFavorite'),
          ),
        ).thenAnswer((_) async {});

        final response =
            await apiCredentialsRepository.updateSicoobApiCredentials(
          database: database,
          id: 'userID',
          clientID: 'clientID',
          certificateBase64String: 'certificateBase64String',
          certificatePassword: 'certificatePassword',
          isFavorite: false,
        );
        verify(() => localApiCredentialsDataSource.updateSicoobApiCredentials(
              id: any(named: 'id'),
              clientID: any(named: 'clientID'),
              certificateBase64String: any(named: 'certificateBase64String'),
              certificatePassword: any(named: 'certificatePassword'),
              isFavorite: any(named: 'isFavorite'),
            ));

        expect(response.isSuccess(), true);
      });
      test('Should return ErrorUpdateApiCredentials on updateBBApiCredentials',
          () async {
        when(
          () => localApiCredentialsDataSource.updateSicoobApiCredentials(
            id: any(named: 'id'),
            clientID: any(named: 'clientID'),
            certificateBase64String: any(named: 'certificateBase64String'),
            certificatePassword: any(named: 'certificatePassword'),
            isFavorite: any(named: 'isFavorite'),
          ),
        ).thenThrow(Exception());
        const expectedResponse =
            'Ocorreu um erro ao atualizar as credenciais do Sicoob';

        final response =
            await apiCredentialsRepository.updateSicoobApiCredentials(
          database: database,
          id: 'userID',
          clientID: 'clientID',
          certificateBase64String: 'certificateBase64String',
          certificatePassword: 'certificatePassword',
          isFavorite: false,
        );

        final result = response.exceptionOrNull();
        expect(result, isNotNull);
        expect(result!.message, equals(expectedResponse));
      });
    });
  });
}
