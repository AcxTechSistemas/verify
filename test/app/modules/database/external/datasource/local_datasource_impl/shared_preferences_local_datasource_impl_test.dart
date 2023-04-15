import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/app/core/register_log.dart';
import 'package:verify/app/core/send_logs_to_web.dart';
import 'package:verify/app/modules/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/modules/database/domain/errors/user_preferences_error.dart';
import 'package:verify/app/modules/database/external/datasource/local_datasource_impl/shared_preferences_local_datasource_impl.dart';
import 'package:verify/app/modules/database/infra/models/bb_api_credentials_model.dart';
import 'package:verify/app/modules/database/infra/models/sicoob_api_credentials_model.dart';
import 'package:verify/app/modules/database/utils/database_enums.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockRegisterLog extends Mock implements RegisterLog {}

class MockSendLogsToWeb extends Mock implements SendLogsToWeb {}

void main() {
  // Declaração das variáveis utilizadas nos testes
  late SharedPreferencesLocalDataSourceImpl dataSource;
  late SharedPreferences sharedPreferences;
  late RegisterLog registerLog;
  late SendLogsToWeb sendLogsToWeb;

  setUp(() {
    registerLog = MockRegisterLog();
    sendLogsToWeb = MockSendLogsToWeb();
    sharedPreferences = MockSharedPreferences();

    // Inicialização da classe que será testada com as variáveis mockadas
    dataSource = SharedPreferencesLocalDataSourceImpl(
      sharedPreferences,
      registerLog,
      sendLogsToWeb,
    );
    when(() => sendLogsToWeb(any())).thenAnswer((_) async {});
  });

  // Agrupamento dos testes relacionados ao SharedPreferencesLocalDataSourceImpl
  group('SharedPreferencesImpl: ', () {
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
        when(() => sharedPreferences.setString(any(), any())).thenAnswer(
          (_) async => true,
        );

        await dataSource.saveBBApiCredentials(
          id: '123',
          applicationDeveloperKey: bbCredentials.applicationDeveloperKey,
          basicKey: bbCredentials.basicKey,
          isFavorite: bbCredentials.isFavorite,
        );
        verify(() => sharedPreferences.setString(
              DocumentName.bbApiCredential.name,
              bbCredentials.toJson(),
            )).called(1);
      });

      // Teste que verifica se o método saveBBApiCredentials() lança uma exceção caso o salvamento falhe
      test('Should throws ErrorSavingApiCredentials if return false', () async {
        when(() => sharedPreferences.setString(any(), any())).thenAnswer(
          (_) async => false,
        );

        try {
          await dataSource.saveBBApiCredentials(
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
        when(() => sharedPreferences.setString(any(), any()))
            .thenThrow(Exception());
        try {
          await dataSource.saveBBApiCredentials(
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
        when(() => sharedPreferences.getString(any())).thenAnswer(
          (_) => bbCredentials.toJson(),
        );

        final bbApiCredentials = await dataSource.readBBApiCredentials(
          id: '123',
        );

        expect(bbApiCredentials, isNotNull);
        expect(bbApiCredentials!.isFavorite, false);
      });

      test('Should return null if doccument not exists', () async {
        when(() => sharedPreferences.getString(any())).thenAnswer(
          (_) => null,
        );

        final bbApiCredentials = await dataSource.readBBApiCredentials(
          id: '123',
        );

        expect(bbApiCredentials, isNull);
      });
      test('Should throws ErrorReadingApiCredentials if failure', () async {
        when(() => sharedPreferences.getString(any())).thenThrow(Exception());
        try {
          await dataSource.readBBApiCredentials(id: '123');
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
        when(() => sharedPreferences.getString(any())).thenAnswer(
          (_) => bbCredentials.toJson(),
        );

        when(() => sharedPreferences.setString(any(), any())).thenAnswer(
          (_) async => true,
        );
        await dataSource.updateBBApiCredentials(
          id: '123',
          applicationDeveloperKey: 'newApplicationDeveloperKey',
          basicKey: 'newBasicKey',
          isFavorite: true,
        );

        verify(() => sharedPreferences.setString(
              DocumentName.bbApiCredential.name,
              BBApiCredentialsModel(
                applicationDeveloperKey: 'newApplicationDeveloperKey',
                basicKey: 'newBasicKey',
                isFavorite: true,
              ).toJson(),
            )).called(1);
      });
      test(
          'Should throws ErrorReadingApiCredentials if Credentials to update does not exists',
          () async {
        when(() => sharedPreferences.getString(any())).thenAnswer(
          (_) => null,
        );

        when(() => sharedPreferences.setString(any(), any())).thenAnswer(
          (_) async => true,
        );

        try {
          await dataSource.updateBBApiCredentials(
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
        when(() => sharedPreferences.getString(any())).thenAnswer(
          (_) => bbCredentials.toJson(),
        );

        when(() => sharedPreferences.setString(any(), any()))
            .thenThrow(Exception());

        try {
          await dataSource.updateBBApiCredentials(
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
        when(() => sharedPreferences.remove(any())).thenAnswer(
          (_) async => true,
        );

        await dataSource.deleteBBApiCredentials(id: '');

        verify(() => sharedPreferences.remove(
              DocumentName.bbApiCredential.name,
            )).called(1);
      });

      test(
          'Should throws ErrorRemovingApiCredentials if return false on remove',
          () async {
        when(() => sharedPreferences.remove(any())).thenAnswer(
          (_) async => false,
        );
        try {
          await dataSource.deleteBBApiCredentials(id: '');
        } catch (e) {
          expect(e, isA<ErrorRemovingApiCredentials>());
        }
      });
      test('Should throws ErrorRemovingApiCredentials on failure', () async {
        when(() => sharedPreferences.remove(any())).thenThrow(Exception());
        try {
          await dataSource.deleteBBApiCredentials(id: '');
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
        when(() => sharedPreferences.setString(any(), any())).thenAnswer(
          (_) async => true,
        );

        await dataSource.saveSicoobApiCredentials(
          id: '123',
          certificateBase64String: 'certString',
          certificatePassword: 'certPassword',
          clientID: 'clientID',
          isFavorite: true,
        );
        verify(() => sharedPreferences.setString(
              DocumentName.sicoobApiCredential.name,
              sicoobCredentials.toJson(),
            )).called(1);
      });

      // Teste que verifica se o método saveBBApiCredentials() lança uma exceção caso o salvamento falhe
      test('Should throws ErrorSavingApiCredentials if return false', () async {
        when(() => sharedPreferences.setString(any(), any())).thenAnswer(
          (_) async => false,
        );

        try {
          await dataSource.saveSicoobApiCredentials(
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
        when(() => sharedPreferences.setString(any(), any()))
            .thenThrow(Exception());
        try {
          await dataSource.saveSicoobApiCredentials(
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
        when(() => sharedPreferences.getString(any())).thenAnswer(
          (_) => sicoobCredentials.toJson(),
        );

        final bbApiCredentials = await dataSource.readSicoobApiCredentials(
          id: '123',
        );

        expect(bbApiCredentials, isNotNull);
        expect(bbApiCredentials!.isFavorite, false);
      });

      test('Should return null if doccument not exists', () async {
        when(() => sharedPreferences.getString(any())).thenAnswer(
          (_) => null,
        );

        final bbApiCredentials = await dataSource.readSicoobApiCredentials(
          id: '123',
        );

        expect(bbApiCredentials, isNull);
      });
      test('Should throws ErrorReadingApiCredentials if failure', () async {
        when(() => sharedPreferences.getString(any())).thenThrow(Exception());
        try {
          await dataSource.readSicoobApiCredentials(id: '123');
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
        when(() => sharedPreferences.getString(any())).thenAnswer(
          (_) => sicoobCredentials.toJson(),
        );

        when(() => sharedPreferences.setString(any(), any())).thenAnswer(
          (_) async => true,
        );
        await dataSource.updateSicoobApiCredentials(
          id: '123',
          certificateBase64String: 'newCertificateBase64String',
          certificatePassword: 'newCertificatePassword',
          clientID: 'newClientID',
          isFavorite: true,
        );

        verify(() => sharedPreferences.setString(
              DocumentName.sicoobApiCredential.name,
              SicoobApiCredentialsModel(
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
        when(() => sharedPreferences.getString(any())).thenAnswer(
          (_) => null,
        );

        when(() => sharedPreferences.setString(any(), any())).thenAnswer(
          (_) async => true,
        );

        try {
          await dataSource.updateSicoobApiCredentials(
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
        when(() => sharedPreferences.getString(any())).thenAnswer(
          (_) => sicoobCredentials.toJson(),
        );

        when(() => sharedPreferences.setString(any(), any()))
            .thenThrow(Exception());

        try {
          await dataSource.updateSicoobApiCredentials(
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
        when(() => sharedPreferences.remove(any())).thenAnswer(
          (_) async => true,
        );

        await dataSource.deleteSicoobApiCredentials(id: '');

        verify(() => sharedPreferences.remove(
              DocumentName.sicoobApiCredential.name,
            )).called(1);
      });

      test(
          'Should throws ErrorRemovingApiCredentials if return false on remove',
          () async {
        when(() => sharedPreferences.remove(any())).thenAnswer(
          (_) async => false,
        );
        try {
          await dataSource.deleteSicoobApiCredentials(id: '');
        } catch (e) {
          expect(e, isA<ErrorRemovingApiCredentials>());
        }
      });
      test('Should throws ErrorRemovingApiCredentials on failure', () async {
        when(() => sharedPreferences.remove(any())).thenThrow(Exception());
        try {
          await dataSource.deleteBBApiCredentials(id: '');
        } catch (e) {
          expect(e, isA<ErrorRemovingApiCredentials>());
        }
      });
    });
    group('UserThemePreferences: ', () {
      test('Should save UserThemePreference on SharedPreferencesDataBase ',
          () async {
        when(() => sharedPreferences.setString(any(), any())).thenAnswer(
          (_) async => true,
        );
        await dataSource.saveUserThemePreference(
          themeMode: ThemeMode.dark,
        );
        verify(() => sharedPreferences.setString(
              DocumentName.userThemePreference.name,
              ThemeMode.dark.name,
            )).called(1);
      });

      test(
          'Should return ThemeMode.light by default if document does not exist',
          () async {
        final themeMode = await dataSource.readUserThemePreference();
        expect(themeMode, equals(ThemeMode.light));
      });
      test('Should return user theme preference on SharedPreferencesDataBase',
          () async {
        when(() => sharedPreferences.getString(any())).thenReturn('dark');
        final themeMode = await dataSource.readUserThemePreference();
        expect(themeMode, equals(ThemeMode.dark));
      });
      test('Should throws ErrorReadUserThemePreference if failure', () async {
        when(() => sharedPreferences.getString(any())).thenThrow(Exception());
        try {
          await dataSource.readUserThemePreference();
        } catch (e) {
          expect(e, isA<ErrorReadUserThemePreference>());
        }
      });
      test('Should update UserThemePreference on SharedPreferencesDataBase',
          () async {
        when(() => sharedPreferences.getString(any())).thenAnswer(
          (_) => 'dark',
        );

        when(() => sharedPreferences.setString(any(), any())).thenAnswer(
          (_) async => true,
        );
        await dataSource.updateUserThemePreference(
          themeMode: ThemeMode.system,
        );

        verify(() => sharedPreferences.setString(
              DocumentName.userThemePreference.name,
              ThemeMode.system.name,
            )).called(1);
      });
      test(
          'Should throws ErrorUpdateUserThemePreference if document to update does not exists',
          () async {
        when(() => sharedPreferences.getString(any())).thenAnswer(
          (_) => null,
        );

        when(() => sharedPreferences.setString(any(), any())).thenAnswer(
          (_) async => true,
        );

        try {
          await dataSource.updateUserThemePreference(
            themeMode: ThemeMode.dark,
          );
        } catch (e) {
          expect(e, isA<ErrorUpdateUserThemePreference>());
        }
      });

      test('Should throws UserThemePreferenceError if failure on update',
          () async {
        when(() => sharedPreferences.getString(any())).thenAnswer(
          (_) => 'dark',
        );

        when(() => sharedPreferences.setString(any(), any()))
            .thenThrow(Exception());

        try {
          await dataSource.updateUserThemePreference(
            themeMode: ThemeMode.light,
          );
        } catch (e) {
          expect(e, isA<ErrorUpdateUserThemePreference>());
        }
      });
    });
  });
}
