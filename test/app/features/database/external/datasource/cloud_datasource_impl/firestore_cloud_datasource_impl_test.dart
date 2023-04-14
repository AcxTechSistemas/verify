import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:verify/app/core/register_log.dart';
import 'package:verify/app/core/send_logs_to_web.dart';
import 'package:verify/app/features/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/features/database/external/datasource/cloud_datasource_impl/errors/firebase_firestore_error_handler.dart';
import 'package:verify/app/features/database/external/datasource/cloud_datasource_impl/firestore_cloud_datasource_impl.dart';
import 'package:verify/app/features/database/infra/models/bb_api_credentials_model.dart';

// ignore: subtype_of_sealed_class
class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

// ignore: subtype_of_sealed_class
class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockRegisterLog extends Mock implements RegisterLog {}

class MockSendLogsToWeb extends Mock implements SendLogsToWeb {}

void main() {
  late FireStoreCloudDataSourceImpl fireStoreCloudDataSource;
  late FirebaseFirestore firestoreMock;
  late MockCollectionReference collectionMock;
  late MockDocumentReference documentMock;
  late FirebaseFirestoreErrorHandler firebaseFirestoreErrorHandler;
  late RegisterLog registerLog;
  late SendLogsToWeb sendLogsToWeb;

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

    fireStoreCloudDataSource = FireStoreCloudDataSourceImpl(
      firestoreMock,
      firebaseFirestoreErrorHandler,
      registerLog,
      sendLogsToWeb,
    );

    when(() => sendLogsToWeb(any())).thenAnswer((_) async {});
    when(() => firestoreMock.collection(any())).thenReturn(collectionMock);
    when(() => collectionMock.doc(any())).thenReturn(documentMock);
  });
  group('FireStoreCloudDataSourceImpl: ', () {
    group('BBApiCredentials: ', () {
      test('should save BBApiCredentials to Firestore', () async {
        when(() => documentMock.set(any())).thenAnswer((_) async => {});
        const id = '123';
        const applicationDeveloperKey = 'appDevKey';
        const basicKey = 'basicKey';
        const isFavorite = true;

        final bbCredentials = BBApiCredentialsModel(
          applicationDeveloperKey: applicationDeveloperKey,
          basicKey: basicKey,
          isFavorite: isFavorite,
        );

        await fireStoreCloudDataSource.saveBBApiCredentials(
          id: id,
          applicationDeveloperKey: applicationDeveloperKey,
          basicKey: basicKey,
          isFavorite: isFavorite,
        );
        verify(() =>
            collectionMock.doc('bbApiCredentials').set(bbCredentials.toMap()));
      });
      test('should throws ErrorSavingApiCredentials if failure', () async {
        final exception = FirebaseException(
          code: 'teste',
          message: 'asd',
          plugin: 'as',
        );
        when(() => registerLog(any())).thenAnswer((_) async {});
        when(() => documentMock.set(any())).thenThrow(exception);
        const id = '123';
        const applicationDeveloperKey = 'appDevKey';
        const basicKey = 'basicKey';
        const isFavorite = true;

        try {
          await fireStoreCloudDataSource.saveBBApiCredentials(
            id: id,
            applicationDeveloperKey: applicationDeveloperKey,
            basicKey: basicKey,
            isFavorite: isFavorite,
          );
          fail('These test should throws ErrorSavingApiCredentials');
        } catch (e) {
          expect(e, isA<ErrorSavingApiCredentials>());
        }
      });
    });
  });
}
