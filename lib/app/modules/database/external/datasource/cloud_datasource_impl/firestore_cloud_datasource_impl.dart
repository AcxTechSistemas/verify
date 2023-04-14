import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:verify/app/core/register_log.dart';
import 'package:verify/app/core/send_logs_to_web.dart';
import 'package:verify/app/modules/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/modules/database/external/datasource/cloud_datasource_impl/errors/firebase_firestore_error_handler.dart';
import 'package:verify/app/modules/database/infra/datasource/api_credentials_datasource.dart';
import 'package:verify/app/modules/database/infra/models/sicoob_api_credentials_model.dart';
import 'package:verify/app/modules/database/infra/models/bb_api_credentials_model.dart';

class FireStoreCloudDataSourceImpl implements ApiCredentialsDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseFirestoreErrorHandler _firebaseFirestoreErrorHandler;
  final RegisterLog _registerLog;
  final SendLogsToWeb _sendLogsToWeb;

  FireStoreCloudDataSourceImpl(
    this._firestore,
    this._firebaseFirestoreErrorHandler,
    this._registerLog,
    this._sendLogsToWeb,
  );
  @override
  Future<void> saveBBApiCredentials({
    required String id,
    required String applicationDeveloperKey,
    required String basicKey,
    required bool isFavorite,
  }) async {
    final bbCredentials = BBApiCredentialsModel(
      applicationDeveloperKey: applicationDeveloperKey,
      basicKey: basicKey,
      isFavorite: isFavorite,
    );
    try {
      await _firestore
          .collection(id)
          .doc('bbApiCredentials')
          .set(bbCredentials.toMap());
    } on FirebaseException catch (e) {
      final errorMessage = await _firebaseFirestoreErrorHandler(e);
      throw ErrorSavingApiCredentials(message: errorMessage);
    } catch (e) {
      await _sendLogsToWeb(e);
      _registerLog(e);
      throw ErrorSavingApiCredentials(
        message: 'Ocorreu um erro ao salvar os dados. tente novamente',
      );
    }
  }

  @override
  Future<BBApiCredentialsModel> readBBApiCredentials({
    required String id,
  }) async {
    try {
      final doc = await _firestore.collection(id).doc('bbApiCredentials').get();
      final data = doc.data();
      if (doc.exists) {
        if (data != null) {
          final applicationDeveloperKey = data['applicationDeveloperKey'];
          final basicKey = data['basicKey'];
          final isFavorite = data['isFavorite'];
          return BBApiCredentialsModel(
            applicationDeveloperKey: applicationDeveloperKey,
            basicKey: basicKey,
            isFavorite: isFavorite,
          );
        } else {
          throw FirebaseException(code: 'empty-documment-data', plugin: '');
        }
      } else {
        throw FirebaseException(code: 'documment-not-found', plugin: '');
      }
    } on FirebaseException catch (e) {
      final errorMessage = await _firebaseFirestoreErrorHandler(e);
      throw ErrorReadingApiCredentials(message: errorMessage);
    } catch (e) {
      await _sendLogsToWeb(e);
      _registerLog(e);
      throw ErrorReadingApiCredentials(
        message: 'Ocorreu um erro ao salvar os dados. tente novamente',
      );
    }
  }

  @override
  Future<void> updateBBApiCredentials(
      {required String id,
      required String applicationDeveloperKey,
      required String basicKey,
      required bool isFavorite}) {
    // TODO: implement updateBBApiCredentials
    throw UnimplementedError();
  }

  @override
  Future<void> deleteBBApiCredentials({required String id}) {
    // TODO: implement deleteBBApiCredentials
    throw UnimplementedError();
  }

  @override
  Future<void> saveSicoobApiCredentials(
      {required String id,
      required String clientID,
      required String certificatePassword,
      required String certificateBase64String,
      required bool isFavorite}) {
    // TODO: implement saveSicoobApiCredentials
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSicoobApiCredentials({required String id}) {
    // TODO: implement deleteSicoobApiCredentials
    throw UnimplementedError();
  }

  @override
  Future<void> updateSicoobApiCredentials(
      {required String id,
      required String clientID,
      required String certificatePassword,
      required String certificateBase64String,
      required bool isFavorite}) {
    // TODO: implement updateSicoobApiCredentials
    throw UnimplementedError();
  }

  @override
  Future<SicoobApiCredentialsModel> readSicoobApiCredentials(
      {required String id}) {
    // TODO: implement readSicoobApiCredentials
    throw UnimplementedError();
  }
}
