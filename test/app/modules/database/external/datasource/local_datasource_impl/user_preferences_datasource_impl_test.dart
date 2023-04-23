import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/app/modules/database/external/datasource/local_datasource_impl/user_preferences_datasource_impl.dart';
import 'package:verify/app/modules/database/infra/datasource/user_preferences_datasource.dart';
import 'package:verify/app/shared/error_registrator/register_log.dart';
import 'package:verify/app/shared/error_registrator/send_logs_to_web.dart';
import 'package:verify/app/modules/database/domain/errors/user_preferences_error.dart';
import 'package:verify/app/modules/database/utils/database_enums.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockRegisterLog extends Mock implements RegisterLog {}

class MockSendLogsToWeb extends Mock implements SendLogsToWeb {}

void main() {
  // Declaração das variáveis utilizadas nos testes
  late UserPreferencesDataSource userPreferencesDataSource;
  late SharedPreferences sharedPreferences;
  late RegisterLog registerLog;
  late SendLogsToWeb sendLogsToWeb;

  setUp(() {
    registerLog = MockRegisterLog();
    sendLogsToWeb = MockSendLogsToWeb();
    sharedPreferences = MockSharedPreferences();

    // Inicialização da classe que será testada com as variáveis mockadas
    userPreferencesDataSource = UserPreferencesLocalDataSourceImpl(
      sharedPreferences,
      registerLog,
      sendLogsToWeb,
    );
    when(() => sendLogsToWeb(any())).thenAnswer((_) async {});
  });

  // Agrupamento dos testes relacionados ao SharedPreferencesLocalDataSourceImpl
  group('UserPreferencesDataSource: ', () {
    // Agrupamento dos testes relacionados à funcionalidade de salvar credenciais da BBApi
    group('UserThemePreferencesDat: ', () {
      test('Should save UserThemePreference on SharedPreferencesDataBase ',
          () async {
        when(() => sharedPreferences.setString(any(), any())).thenAnswer(
          (_) async => true,
        );
        await userPreferencesDataSource.saveUserThemePreference(
          themeMode: ThemeMode.dark,
        );
        verify(() => sharedPreferences.setString(
              DocumentName.userThemePreference.name,
              ThemeMode.dark.name,
            )).called(1);
      });

      test('Should return user theme preference on SharedPreferencesDataBase',
          () async {
        when(() => sharedPreferences.getString(any())).thenReturn('dark');
        final themeMode =
            await userPreferencesDataSource.readUserThemePreference();
        expect(themeMode, equals(ThemeMode.dark));
      });
      test('Should throws ErrorReadUserThemePreference if failure', () async {
        when(() => sharedPreferences.getString(any())).thenThrow(Exception());
        try {
          await userPreferencesDataSource.readUserThemePreference();
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
        await userPreferencesDataSource.updateUserThemePreference(
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
          await userPreferencesDataSource.updateUserThemePreference(
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
          await userPreferencesDataSource.updateUserThemePreference(
            themeMode: ThemeMode.light,
          );
        } catch (e) {
          expect(e, isA<ErrorUpdateUserThemePreference>());
        }
      });
    });
  });
}
