import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/app/core/register_log.dart';
import 'package:verify/app/core/send_logs_to_web.dart';
import 'package:verify/app/modules/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/modules/database/external/datasource/local_datasource_impl/shared_preferences_local_datasource_impl.dart';
import 'package:verify/app/modules/database/infra/models/bb_api_credentials_model.dart';

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
  });
}
