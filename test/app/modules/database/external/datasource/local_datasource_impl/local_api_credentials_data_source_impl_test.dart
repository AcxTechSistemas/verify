import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:verify/app/modules/database/external/datasource/local_datasource_impl/local_api_credentials_data_source_impl.dart';
import 'package:verify/app/modules/database/infra/datasource/local_api_credentials_datasource.dart';
import 'package:verify/app/shared/error_registrator/register_log.dart';
import 'package:verify/app/shared/error_registrator/send_logs_to_web.dart';
import 'package:verify/app/modules/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/modules/database/infra/models/bb_api_credentials_model.dart';
import 'package:verify/app/modules/database/infra/models/sicoob_api_credentials_model.dart';
import 'package:verify/app/modules/database/utils/database_enums.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

class MockRegisterLog extends Mock implements RegisterLog {}

class MockSendLogsToWeb extends Mock implements SendLogsToWeb {}

void main() {
  // Declaração das variáveis utilizadas nos testes
  late LocalApiCredentialsDataSource localApiCredentialsDataSource;
  late RegisterLog registerLog;
  late SendLogsToWeb sendLogsToWeb;
  late FlutterSecureStorage flutterSecureStorage;

  setUp(() {
    registerLog = MockRegisterLog();
    sendLogsToWeb = MockSendLogsToWeb();
    flutterSecureStorage = MockFlutterSecureStorage();

    // Inicialização da classe que será testada com as variáveis mockadas
    localApiCredentialsDataSource = LocalApiCredentialsDataSourceImpl(
      flutterSecureStorage,
      registerLog,
      sendLogsToWeb,
    );
    when(() => sendLogsToWeb(any())).thenAnswer((_) async {});
  });

  // Agrupamento dos testes relacionados ao SharedPreferencesLocalDataSourceImpl
  group('LocalApiCredentialsDataSource: ', () {
    // Agrupamento dos testes relacionados à funcionalidade de salvar credenciais da BBApi
    group('BBApiCredentials: ', () {
      // Teste que verifica se o método saveBBApiCredentials() salva as credenciais corretamente
      test('Should save BBApiCredentials on SharedPreferencesDataBase',
          () async {
        final bbCredentials = BBApiCredentialsModel(
          applicationDeveloperKey: 'applicationDeveloperKey',
          basicKey: 'basicKey',
          isFavorite: true,
        );

        when(() => flutterSecureStorage.write(
              key: any(named: 'key'),
              value: any(named: 'value'),
            )).thenAnswer((_) async => true);

        await localApiCredentialsDataSource.saveBBApiCredentials(
          id: '123',
          applicationDeveloperKey: bbCredentials.applicationDeveloperKey,
          basicKey: bbCredentials.basicKey,
          isFavorite: bbCredentials.isFavorite,
        );
        verify(() => flutterSecureStorage.write(
              key: DocumentName.bbApiCredential.name,
              value: bbCredentials.toJson(),
            )).called(1);
      });

      // Teste que verifica se o método saveBBApiCredentials() lança uma exceção caso o salvamento falhe
      test('Should throws ErrorSavingApiCredentials if return false', () async {
        when(() => flutterSecureStorage.write(
              key: any(named: 'key'),
              value: any(named: 'value'),
            )).thenAnswer((_) async => false);

        try {
          await localApiCredentialsDataSource.saveBBApiCredentials(
            id: '123',
            applicationDeveloperKey: 'appDevKey',
            basicKey: 'basicKey',
            isFavorite: true,
          );
        } catch (e) {
          expect(e, isA<ErrorSavingApiCredentials>());
        }
      });

      // Teste que verifica se o método saveBBApiCredentials() lança uma exceção caso ocorra uma falha inesperada
      test('Should throws ErrorSavingApiCredentials if failure', () async {
        when(() => flutterSecureStorage.write(
              key: any(named: 'key'),
              value: any(named: 'value'),
            )).thenThrow(Exception());

        try {
          await localApiCredentialsDataSource.saveBBApiCredentials(
            id: '123',
            applicationDeveloperKey: 'appDevKey',
            basicKey: 'basicKey',
            isFavorite: true,
          );
        } catch (e) {
          expect(e, isA<ErrorSavingApiCredentials>());
        }
      });
      test('Should return BBApiCredentials on SharedPreferencesDataBase',
          () async {
        final bbCredentials = BBApiCredentialsModel(
          applicationDeveloperKey: 'applicationDeveloperKey',
          basicKey: 'basicKey',
          isFavorite: false,
        );
        when(() => flutterSecureStorage.read(
              key: any(named: 'key'),
            )).thenAnswer((_) async => bbCredentials.toJson());

        final bbApiCredentials =
            await localApiCredentialsDataSource.readBBApiCredentials(
          id: '123',
        );

        expect(bbApiCredentials, isNotNull);
        expect(bbApiCredentials!.isFavorite, false);
      });

      test('Should return null if doccument not exists', () async {
        when(() => flutterSecureStorage.read(
              key: any(named: 'key'),
            )).thenAnswer((_) async => null);

        final bbApiCredentials =
            await localApiCredentialsDataSource.readBBApiCredentials(
          id: '123',
        );

        expect(bbApiCredentials, isNull);
      });
      test('Should throws ErrorReadingApiCredentials if failure', () async {
        when(() => flutterSecureStorage.read(
              key: any(named: 'key'),
            )).thenThrow(Exception());

        try {
          await localApiCredentialsDataSource.readBBApiCredentials(id: '123');
        } catch (e) {
          expect(e, isA<ErrorReadingApiCredentials>());
        }
      });
      test('Should update BBApiCredentials on SharedPreferencesDataBase',
          () async {
        final bbCredentials = BBApiCredentialsModel(
          applicationDeveloperKey: 'newApplicationDeveloperKey',
          basicKey: 'newBasicKey',
          isFavorite: true,
        );
        when(() => flutterSecureStorage.read(key: any(named: 'key')))
            .thenAnswer((_) async => bbCredentials.toJson());

        when(() => flutterSecureStorage.write(
              key: any(named: 'key'),
              value: any(named: 'value'),
            )).thenAnswer((_) async => true);

        await localApiCredentialsDataSource.updateBBApiCredentials(
          id: '123',
          applicationDeveloperKey: 'newApplicationDeveloperKey',
          basicKey: 'newBasicKey',
          isFavorite: true,
        );

        verify(() => flutterSecureStorage.write(
              key: DocumentName.bbApiCredential.name,
              value: BBApiCredentialsModel(
                applicationDeveloperKey: 'newApplicationDeveloperKey',
                basicKey: 'newBasicKey',
                isFavorite: true,
              ).toJson(),
            )).called(1);
      });
      test(
          'Should throws ErrorReadingApiCredentials if Credentials to update does not exists',
          () async {
        when(() => flutterSecureStorage.read(key: any(named: 'key')))
            .thenAnswer((_) async => null);

        when(() => flutterSecureStorage.write(
              key: any(named: 'key'),
              value: any(named: 'value'),
            )).thenAnswer((_) async => true);

        try {
          await localApiCredentialsDataSource.updateBBApiCredentials(
            id: '123',
            applicationDeveloperKey: 'newApplicationDeveloperKey',
            basicKey: 'newBasicKey',
            isFavorite: true,
          );
        } catch (e) {
          expect(e, isA<ErrorReadingApiCredentials>());
        }
      });

      test('Should throws ErrorUpdateApiCredentials if failure', () async {
        final bbCredentials = BBApiCredentialsModel(
          applicationDeveloperKey: 'newApplicationDeveloperKey',
          basicKey: 'newBasicKey',
          isFavorite: true,
        );
        when(() => flutterSecureStorage.read(key: any(named: 'key')))
            .thenAnswer((_) async => bbCredentials.toJson());

        when(() => flutterSecureStorage.write(
              key: any(named: 'key'),
              value: any(named: 'value'),
            )).thenThrow(Exception());

        try {
          await localApiCredentialsDataSource.updateBBApiCredentials(
            id: '123',
            applicationDeveloperKey: 'newApplicationDeveloperKey',
            basicKey: 'newBasicKey',
            isFavorite: true,
          );
        } catch (e) {
          expect(e, isA<ErrorUpdateApiCredentials>());
        }
      });

      test('Should remove BBApiCredentials on SharedPreferencesDataBase',
          () async {
        when(() => flutterSecureStorage.delete(key: any(named: 'key')))
            .thenAnswer((_) async => true);

        await localApiCredentialsDataSource.deleteBBApiCredentials(id: '');

        verify(() => flutterSecureStorage.delete(
              key: DocumentName.bbApiCredential.name,
            )).called(1);
      });

      test(
          'Should throws ErrorRemovingApiCredentials if return false on remove',
          () async {
        when(() => flutterSecureStorage.delete(key: any(named: 'key')))
            .thenAnswer((_) async => false);
        try {
          await localApiCredentialsDataSource.deleteBBApiCredentials(id: '');
        } catch (e) {
          expect(e, isA<ErrorRemovingApiCredentials>());
        }
      });
      test('Should throws ErrorRemovingApiCredentials on failure', () async {
        when(() => flutterSecureStorage.delete(key: any(named: 'key')))
            .thenThrow(Exception());

        try {
          await localApiCredentialsDataSource.deleteBBApiCredentials(id: '');
        } catch (e) {
          expect(e, isA<ErrorRemovingApiCredentials>());
        }
      });
    });
    group('SicoobApiCredentials: ', () {
      test('Should save SicoobApiCredentials on SharedPreferencesDataBase',
          () async {
        final sicoobCredentials = SicoobApiCredentialsModel(
          certificateBase64String: 'certString',
          certificatePassword: 'certPassword',
          clientID: 'clientID',
          isFavorite: true,
        );
        when(() => flutterSecureStorage.write(
            key: any(named: 'key'), value: any(named: 'value'))).thenAnswer(
          (_) async => true,
        );

        await localApiCredentialsDataSource.saveSicoobApiCredentials(
          id: '123',
          certificateBase64String: 'certString',
          certificatePassword: 'certPassword',
          clientID: 'clientID',
          isFavorite: true,
        );
        verify(() => flutterSecureStorage.write(
              key: DocumentName.sicoobApiCredential.name,
              value: sicoobCredentials.toJson(),
            )).called(1);
      });

      // Teste que verifica se o método saveBBApiCredentials() lança uma exceção caso o salvamento falhe
      test('Should throws ErrorSavingApiCredentials if return false', () async {
        when(() => flutterSecureStorage.write(
            key: any(named: 'key'), value: any(named: 'value'))).thenAnswer(
          (_) async => false,
        );

        try {
          await localApiCredentialsDataSource.saveSicoobApiCredentials(
            id: '123',
            certificateBase64String: 'certString',
            certificatePassword: 'certPassword',
            clientID: 'clientID',
            isFavorite: true,
          );
        } catch (e) {
          expect(e, isA<ErrorSavingApiCredentials>());
        }
      });

      // Teste que verifica se o método saveBBApiCredentials() lança uma exceção caso ocorra uma falha inesperada
      test('Should throws ErrorSavingApiCredentials if failure', () async {
        when(() => flutterSecureStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'))).thenThrow(Exception());
        try {
          await localApiCredentialsDataSource.saveSicoobApiCredentials(
            id: '123',
            certificateBase64String: 'certString',
            certificatePassword: 'certPassword',
            clientID: 'clientID',
            isFavorite: true,
          );
        } catch (e) {
          expect(e, isA<ErrorSavingApiCredentials>());
        }
      });
      test(
          'Should return SicoobApiCredentialsModel on SharedPreferencesDataBase',
          () async {
        final sicoobCredentials = SicoobApiCredentialsModel(
          certificateBase64String: 'certString',
          certificatePassword: 'certPassword',
          clientID: 'clientID',
          isFavorite: false,
        );
        when(() => flutterSecureStorage.read(key: any(named: 'key')))
            .thenAnswer(
          (_) async => sicoobCredentials.toJson(),
        );

        final bbApiCredentials =
            await localApiCredentialsDataSource.readSicoobApiCredentials(
          id: '123',
        );

        expect(bbApiCredentials, isNotNull);
        expect(bbApiCredentials!.isFavorite, false);
      });

      test('Should return null if doccument not exists', () async {
        when(() => flutterSecureStorage.read(key: any(named: 'key')))
            .thenAnswer(
          (_) async => null,
        );

        final bbApiCredentials =
            await localApiCredentialsDataSource.readSicoobApiCredentials(
          id: '123',
        );

        expect(bbApiCredentials, isNull);
      });
      test('Should throws ErrorReadingApiCredentials if failure', () async {
        when(() => flutterSecureStorage.read(key: any(named: 'key')))
            .thenThrow(Exception());
        try {
          await localApiCredentialsDataSource.readSicoobApiCredentials(
              id: '123');
        } catch (e) {
          expect(e, isA<ErrorReadingApiCredentials>());
        }
      });

      test('Should update SicoobApiCredentials on SharedPreferencesDataBase',
          () async {
        final sicoobCredentials = SicoobApiCredentialsModel(
          certificateBase64String: 'certString',
          certificatePassword: 'certPassword',
          clientID: 'clientID',
          isFavorite: true,
        );
        when(() => flutterSecureStorage.read(key: any(named: 'key')))
            .thenAnswer(
          (_) async => sicoobCredentials.toJson(),
        );

        when(() => flutterSecureStorage.write(
            key: any(named: 'key'), value: any(named: 'value'))).thenAnswer(
          (_) async => true,
        );
        await localApiCredentialsDataSource.updateSicoobApiCredentials(
          id: '123',
          certificateBase64String: 'newCertificateBase64String',
          certificatePassword: 'newCertificatePassword',
          clientID: 'newClientID',
          isFavorite: true,
        );

        verify(() => flutterSecureStorage.write(
              key: DocumentName.sicoobApiCredential.name,
              value: SicoobApiCredentialsModel(
                certificateBase64String: 'newCertificateBase64String',
                certificatePassword: 'newCertificatePassword',
                clientID: 'newClientID',
                isFavorite: true,
              ).toJson(),
            )).called(1);
      });
      test(
          'Should throws ErrorReadingApiCredentials if Credentials to update does not exists',
          () async {
        when(() => flutterSecureStorage.read(key: any(named: 'key')))
            .thenAnswer(
          (_) async => null,
        );

        when(() => flutterSecureStorage.write(
            key: any(named: 'key'), value: any(named: 'value'))).thenAnswer(
          (_) async => true,
        );

        try {
          await localApiCredentialsDataSource.updateSicoobApiCredentials(
            id: '123',
            certificateBase64String: 'newCertificateBase64String',
            certificatePassword: 'newCertificatePassword',
            clientID: 'newClientID',
            isFavorite: true,
          );
        } catch (e) {
          expect(e, isA<ErrorReadingApiCredentials>());
        }
      });

      test('Should throws ErrorUpdateApiCredentials if failure', () async {
        final sicoobCredentials = SicoobApiCredentialsModel(
          certificateBase64String: 'certString',
          certificatePassword: 'certPassword',
          clientID: 'clientID',
          isFavorite: true,
        );
        when(() => flutterSecureStorage.read(key: any(named: 'key')))
            .thenAnswer(
          (_) async => sicoobCredentials.toJson(),
        );

        when(() => flutterSecureStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'))).thenThrow(Exception());

        try {
          await localApiCredentialsDataSource.updateSicoobApiCredentials(
            id: '123',
            certificateBase64String: 'newCertificateBase64String',
            certificatePassword: 'newCertificatePassword',
            clientID: 'newClientID',
            isFavorite: true,
          );
        } catch (e) {
          expect(e, isA<ErrorUpdateApiCredentials>());
        }
      });

      test('Should remove BBApiCredentials on SharedPreferencesDataBase',
          () async {
        when(() => flutterSecureStorage.delete(
              key: any(named: 'key'),
            )).thenAnswer((_) async => true);

        await localApiCredentialsDataSource.deleteSicoobApiCredentials(id: '');

        verify(() => flutterSecureStorage.delete(
              key: DocumentName.sicoobApiCredential.name,
            )).called(1);
      });

      test(
          'Should throws ErrorRemovingApiCredentials if return false on remove',
          () async {
        when(() => flutterSecureStorage.delete(key: any(named: 'key')))
            .thenAnswer(
          (_) async => false,
        );
        try {
          await localApiCredentialsDataSource.deleteSicoobApiCredentials(
              id: '');
        } catch (e) {
          expect(e, isA<ErrorRemovingApiCredentials>());
        }
      });
      test('Should throws ErrorRemovingApiCredentials on failure', () async {
        when(() => flutterSecureStorage.delete(key: any(named: 'key')))
            .thenThrow(Exception());
        try {
          await localApiCredentialsDataSource.deleteBBApiCredentials(id: '');
        } catch (e) {
          expect(e, isA<ErrorRemovingApiCredentials>());
        }
      });
    });
  });
}
