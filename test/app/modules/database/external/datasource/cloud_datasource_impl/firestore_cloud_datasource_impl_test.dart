import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:verify/app/modules/database/external/datasource/cloud_datasource_impl/cloud_api_credentials_datasource_impl.dart';
import 'package:verify/app/modules/database/infra/datasource/cloud_api_credentials_datasource.dart';
import 'package:verify/app/shared/error_registrator/register_log.dart';
import 'package:verify/app/shared/error_registrator/send_logs_to_web.dart';
import 'package:verify/app/modules/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/modules/database/external/datasource/cloud_datasource_impl/error_handler/firebase_firestore_error_handler.dart';
import 'package:verify/app/modules/database/infra/models/bb_api_credentials_model.dart';
import 'package:verify/app/modules/database/infra/models/sicoob_api_credentials_model.dart';
import 'package:verify/app/modules/database/utils/database_enums.dart';

// ignore: subtype_of_sealed_class
class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

// ignore: subtype_of_sealed_class
class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockRegisterLog extends Mock implements RegisterLog {}

class MockSendLogsToWeb extends Mock implements SendLogsToWeb {}

// ignore: subtype_of_sealed_class
class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

void main() {
  late CloudApiCredentialsDataSource fireStoreCloudDataSource;
  late FirebaseFirestore firestoreMock;
  late MockCollectionReference collectionMock;
  late MockDocumentReference documentMock;
  late FirebaseFirestoreErrorHandler firebaseFirestoreErrorHandler;
  late RegisterLog registerLog;
  late SendLogsToWeb sendLogsToWeb;
  late DocumentSnapshot<Map<String, dynamic>> documentSnapshot;

  setUp(() {
    firestoreMock = MockFirebaseFirestore();
    collectionMock = MockCollectionReference();
    documentMock = MockDocumentReference();
    registerLog = MockRegisterLog();
    sendLogsToWeb = MockSendLogsToWeb();
    firebaseFirestoreErrorHandler = FirebaseFirestoreErrorHandler(
      registerLog,
      sendLogsToWeb,
    );

    fireStoreCloudDataSource = CloudApiCredentialsDataSourceImpl(
      firestoreMock,
      firebaseFirestoreErrorHandler,
      registerLog,
      sendLogsToWeb,
    );

    documentSnapshot = MockDocumentSnapshot();
    when(() => sendLogsToWeb(any())).thenAnswer((_) async {});
    when(() => firestoreMock.collection(any())).thenReturn(collectionMock);
    when(() => collectionMock.doc(any())).thenReturn(documentMock);
  });
  group('FireStoreCloudDataSourceImpl: ', () {
    group('BBApiCredentials: ', () {
      test('should save BBApiCredentials to Firestore', () async {
        when(() => documentMock.set(any())).thenAnswer((_) async => {});
        await fireStoreCloudDataSource.saveBBApiCredentials(
          id: '123',
          applicationDeveloperKey: 'appDevKey',
          basicKey: 'basicKey',
          isFavorite: true,
        );
        verify(() => collectionMock
            .doc(DocumentName.bbApiCredential.name)
            .set(any())).called(1);
      });
      test('should throws ErrorSavingApiCredentials if failure', () async {
        final exception = FirebaseException(
          code: 'teste',
          message: 'errorMessage',
          plugin: '',
        );
        when(() => registerLog(any())).thenAnswer((_) async {});
        when(() => documentMock.set(any())).thenThrow(exception);

        try {
          await fireStoreCloudDataSource.saveBBApiCredentials(
            id: '123',
            applicationDeveloperKey: 'appDevKey',
            basicKey: 'basicKey',
            isFavorite: true,
          );
          fail('These test should throws ErrorSavingApiCredentials');
        } catch (e) {
          expect(e, isA<ErrorSavingApiCredentials>());
        }
      });
      test('should return BBApiCredentialsModel on readBBApiCredentials',
          () async {
        when(() => documentMock.get(any()))
            .thenAnswer((_) async => documentSnapshot);

        const id = '123';

        final bbCredentials = BBApiCredentialsModel(
          applicationDeveloperKey: 'appDevKey',
          basicKey: 'basicKey',
          isFavorite: true,
        );

        when(() => documentSnapshot.exists).thenReturn(true);
        when(() => documentSnapshot.data()).thenReturn(
          bbCredentials.toMap(),
        );

        final bbApiCredentials =
            await fireStoreCloudDataSource.readBBApiCredentials(
          id: id,
        );

        expect(bbApiCredentials, isNotNull);
        expect(bbApiCredentials!.basicKey, equals('basicKey'));
      });

      test('should return null if documment not exists', () async {
        when(() => documentMock.get(any()))
            .thenAnswer((_) async => documentSnapshot);

        const id = '123';
        when(() => documentSnapshot.exists).thenReturn(false);

        final bbApiCredentials =
            await fireStoreCloudDataSource.readBBApiCredentials(
          id: id,
        );
        expect(bbApiCredentials, isNull);
      });
      test('should return null if documment is empty', () async {
        when(() => documentMock.get(any()))
            .thenAnswer((_) async => documentSnapshot);

        const id = '123';
        when(() => documentSnapshot.exists).thenReturn(true);
        when(() => documentSnapshot.data()).thenReturn(null);

        final bbApiCredentials =
            await fireStoreCloudDataSource.readBBApiCredentials(
          id: id,
        );
        expect(bbApiCredentials, isNull);
      });
      test('should throws ErrorReadingApiCredentials if failure', () async {
        when(() => documentMock.get(any())).thenThrow(Exception());

        const id = '123';
        when(() => documentSnapshot.exists).thenReturn(true);
        when(() => documentSnapshot.data()).thenReturn(null);
        try {
          await fireStoreCloudDataSource.readBBApiCredentials(
            id: id,
          );
          fail('These test should throws ErrorReadingApiCredentials');
        } catch (e) {
          expect(e, isA<ErrorReadingApiCredentials>());
        }
      });

      test('should update BBApiCredentials on firestore', () async {
        when(() => documentMock.update(any())).thenAnswer((_) async => {});

        await fireStoreCloudDataSource.updateBBApiCredentials(
          id: '123',
          applicationDeveloperKey: 'appDevKey',
          basicKey: 'basicKey',
          isFavorite: true,
        );
        verify(() => collectionMock.doc(any()).update(any())).called(1);
      });

      test('should throws ErrorUpdateApiCredentials if failure', () async {
        final exception = FirebaseException(
          code: 'teste',
          message: 'errorMessage',
          plugin: '',
        );
        when(() => registerLog(any())).thenAnswer((_) async {});
        when(() => documentMock.update(any())).thenThrow(exception);
        const id = '123';
        const applicationDeveloperKey = 'appDevKey';
        const basicKey = 'basicKey';
        const isFavorite = true;

        try {
          await fireStoreCloudDataSource.updateBBApiCredentials(
            id: id,
            applicationDeveloperKey: applicationDeveloperKey,
            basicKey: basicKey,
            isFavorite: isFavorite,
          );
          fail('These test should throws ErrorSavingApiCredentials');
        } catch (e) {
          expect(e, isA<ErrorUpdateApiCredentials>());
        }
      });

      test('should remove BBApiCredentials in Firestore', () async {
        when(() => documentMock.delete()).thenAnswer((_) async => {});
        await fireStoreCloudDataSource.deleteBBApiCredentials(
          id: '123',
        );
        verify(() => collectionMock.doc(any()).delete()).called(1);
      });
      test('should throws ErrorRemovingApiCredentials if Failure', () async {
        when(() => documentMock.delete()).thenThrow(Exception());
        try {
          await fireStoreCloudDataSource.deleteBBApiCredentials(
            id: '123',
          );
          fail('These test should throws ErrorRemovingApiCredentials');
        } catch (e) {
          expect(e, isA<ErrorRemovingApiCredentials>());
        }
      });
    });

    group('SicoobApiCredentials: ', () {
      test('should save SicoobApiCredentials to Firestore', () async {
        when(() => documentMock.set(any())).thenAnswer((_) async => {});
        await fireStoreCloudDataSource.saveSicoobApiCredentials(
          id: '123',
          certificateBase64String: 'certString',
          certificatePassword: 'certPassword',
          clientID: 'clientID',
          isFavorite: true,
        );
        verify(() => collectionMock
            .doc(DocumentName.sicoobApiCredential.name)
            .set(any())).called(1);
      });
      test('should throws ErrorSavingApiCredentials if failure', () async {
        final exception = FirebaseException(
          code: 'teste',
          message: 'errorMessage',
          plugin: '',
        );
        when(() => registerLog(any())).thenAnswer((_) async {});
        when(() => documentMock.set(any())).thenThrow(exception);

        try {
          await fireStoreCloudDataSource.saveSicoobApiCredentials(
            id: '123',
            certificateBase64String: 'certString',
            certificatePassword: 'certPassword',
            clientID: 'clientID',
            isFavorite: true,
          );
          fail('These test should throws ErrorSavingApiCredentials');
        } catch (e) {
          expect(e, isA<ErrorSavingApiCredentials>());
        }
      });
      test(
          'should return SicoobApiCredentialsModel on readSicoobApiCredentials',
          () async {
        when(() => documentMock.get(any()))
            .thenAnswer((_) async => documentSnapshot);

        const id = '123';

        final sicoobCredentials = SicoobApiCredentialsModel(
          certificateBase64String: 'certString',
          certificatePassword: 'certPassword',
          clientID: 'clientID',
          isFavorite: true,
        );

        when(() => documentSnapshot.exists).thenReturn(true);
        when(() => documentSnapshot.data()).thenReturn(
          sicoobCredentials.toMap(),
        );

        final sicoobApiCredentials =
            await fireStoreCloudDataSource.readSicoobApiCredentials(id: id);

        expect(sicoobApiCredentials, isNotNull);
        expect(sicoobApiCredentials!.clientID, equals('clientID'));
      });
      test('should return null if documment not exists', () async {
        when(() => documentMock.get(any()))
            .thenAnswer((_) async => documentSnapshot);

        const id = '123';
        when(() => documentSnapshot.exists).thenReturn(false);

        final sicoobApiCredentials =
            await fireStoreCloudDataSource.readSicoobApiCredentials(
          id: id,
        );
        expect(sicoobApiCredentials, isNull);
      });
      test('should return null if documment is empty', () async {
        when(() => documentMock.get(any()))
            .thenAnswer((_) async => documentSnapshot);

        const id = '123';
        when(() => documentSnapshot.exists).thenReturn(true);
        when(() => documentSnapshot.data()).thenReturn(null);

        final sicoobApiCredentials =
            await fireStoreCloudDataSource.readSicoobApiCredentials(
          id: id,
        );
        expect(sicoobApiCredentials, isNull);
      });
      test('should throws ErrorReadingApiCredentials if failure', () async {
        when(() => documentMock.get(any())).thenThrow(Exception());

        const id = '123';
        when(() => documentSnapshot.exists).thenReturn(true);
        when(() => documentSnapshot.data()).thenReturn(null);
        try {
          await fireStoreCloudDataSource.readSicoobApiCredentials(
            id: id,
          );
          fail('These test should throws ErrorReadingApiCredentials');
        } catch (e) {
          expect(e, isA<ErrorReadingApiCredentials>());
        }
      });
      test('should update SicoobApiCredentials on firestore', () async {
        when(() => documentMock.update(any())).thenAnswer((_) async => {});

        await fireStoreCloudDataSource.updateSicoobApiCredentials(
          id: '123',
          certificateBase64String: 'certString',
          certificatePassword: 'certPassword',
          clientID: 'clientID',
          isFavorite: true,
        );
        verify(() => collectionMock.doc(any()).update(any())).called(1);
      });

      test('should throws ErrorUpdateApiCredentials if failure', () async {
        final exception = FirebaseException(
          code: 'teste',
          message: 'errorMessage',
          plugin: '',
        );
        when(() => registerLog(any())).thenAnswer((_) async {});
        when(() => documentMock.update(any())).thenThrow(exception);
        const id = '123';

        try {
          await fireStoreCloudDataSource.updateSicoobApiCredentials(
            id: id,
            certificateBase64String: 'certString',
            certificatePassword: 'certPassword',
            clientID: 'clientID',
            isFavorite: true,
          );
          fail('These test should throws ErrorSavingApiCredentials');
        } catch (e) {
          expect(e, isA<ErrorUpdateApiCredentials>());
        }
      });

      test('should remove SicoobApiCredentials in Firestore', () async {
        when(() => documentMock.delete()).thenAnswer((_) async => {});
        await fireStoreCloudDataSource.deleteSicoobApiCredentials(
          id: '123',
        );
        verify(() => collectionMock.doc(any()).delete()).called(1);
      });
      test('should throws ErrorRemovingApiCredentials if Failure', () async {
        when(() => documentMock.delete()).thenThrow(Exception());
        try {
          await fireStoreCloudDataSource.deleteSicoobApiCredentials(
            id: '123',
          );
          fail('These test should throws ErrorRemovingApiCredentials');
        } catch (e) {
          expect(e, isA<ErrorRemovingApiCredentials>());
        }
      });
    });
  });
}
