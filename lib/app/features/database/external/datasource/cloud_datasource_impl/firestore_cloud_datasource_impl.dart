import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:verify/app/core/register_log.dart';
import 'package:verify/app/core/send_logs_to_web.dart';
import 'package:verify/app/features/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/features/database/external/datasource/cloud_datasource_impl/errors/firebase_firestore_error_handler.dart';
import 'package:verify/app/features/database/infra/datasource/api_credentials_datasource.dart';
import 'package:verify/app/features/database/infra/models/sicoob_api_credentials_model.dart';
import 'package:verify/app/features/database/infra/models/bb_api_credentials_model.dart';

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
  Future<BBApiCredentialsModel> readBBApiCredentials({required String id}) {
    // TODO: implement readBBApiCredentials
    throw UnimplementedError();
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
