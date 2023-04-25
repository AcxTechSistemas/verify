import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:verify/app/modules/database/utils/data_crypto.dart';
import 'package:verify/app/shared/error_registrator/register_log.dart';
import 'package:verify/app/shared/error_registrator/send_logs_to_web.dart';
import 'package:verify/app/modules/database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/modules/database/external/datasource/cloud_datasource_impl/error_handler/firebase_firestore_error_handler.dart';
import 'package:verify/app/modules/database/infra/datasource/cloud_api_credentials_datasource.dart';
import 'package:verify/app/modules/database/infra/models/sicoob_api_credentials_model.dart';
import 'package:verify/app/modules/database/infra/models/bb_api_credentials_model.dart';
import 'package:verify/app/modules/database/utils/database_enums.dart';

class CloudApiCredentialsDataSourceImpl
    implements CloudApiCredentialsDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseFirestoreErrorHandler _firebaseFirestoreErrorHandler;
  final RegisterLog _registerLog;
  final SendLogsToWeb _sendLogsToWeb;
  final DataCrypto _dataCrypto;

  CloudApiCredentialsDataSourceImpl(
    this._firestore,
    this._firebaseFirestoreErrorHandler,
    this._registerLog,
    this._sendLogsToWeb,
    this._dataCrypto,
  );
  @override
  Future<void> saveBBApiCredentials({
    required String id,
    required String applicationDeveloperKey,
    required String basicKey,
    required bool isFavorite,
  }) async {
    final key = _dataCrypto.generateKey(userId: id);
    final encyptedApplicationDeveloperKey = _dataCrypto.encrypt(
      plainText: applicationDeveloperKey,
      key: key,
    );
    final encyptedBasicKey = _dataCrypto.encrypt(
      plainText: basicKey,
      key: key,
    );
    final bbCredentials = BBApiCredentialsModel(
      applicationDeveloperKey: encyptedApplicationDeveloperKey,
      basicKey: encyptedBasicKey,
      isFavorite: isFavorite,
    );
    try {
      await _firestore
          .collection('users')
          .doc(id)
          .collection('apiCredentials')
          .doc(DocumentName.bbApiCredential.name)
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
  Future<BBApiCredentialsModel?> readBBApiCredentials({
    required String id,
  }) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(id)
          .collection('apiCredentials')
          .doc(DocumentName.bbApiCredential.name)
          .get();
      final data = doc.data();
      if (doc.exists) {
        if (data != null) {
          final key = _dataCrypto.generateKey(userId: id);
          final decryptedApplicationDeveloperKey = _dataCrypto.decrypt(
            cipherText: data['applicationDeveloperKey'],
            key: key,
          );
          final decryptedBasicKey = _dataCrypto.decrypt(
            cipherText: data['basicKey'],
            key: key,
          );
          final isFavorite = data['isFavorite'];
          return BBApiCredentialsModel(
            applicationDeveloperKey: decryptedApplicationDeveloperKey,
            basicKey: decryptedBasicKey,
            isFavorite: isFavorite,
          );
        } else {
          return null;
        }
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      final errorMessage = await _firebaseFirestoreErrorHandler(e);
      throw ErrorReadingApiCredentials(message: errorMessage);
    } catch (e) {
      await _sendLogsToWeb(e);
      _registerLog(e);
      throw ErrorReadingApiCredentials(
        message: 'Ocorreu um erro ao recuperar os dados. tente novamente',
      );
    }
  }

  @override
  Future<void> updateBBApiCredentials({
    required String id,
    required String applicationDeveloperKey,
    required String basicKey,
    required bool isFavorite,
  }) async {
    final key = _dataCrypto.generateKey(userId: id);
    final encyptedApplicationDeveloperKey = _dataCrypto.encrypt(
      plainText: applicationDeveloperKey,
      key: key,
    );
    final encyptedBasicKey = _dataCrypto.encrypt(
      plainText: basicKey,
      key: key,
    );
    final bbCredentials = BBApiCredentialsModel(
      applicationDeveloperKey: encyptedApplicationDeveloperKey,
      basicKey: encyptedBasicKey,
      isFavorite: isFavorite,
    );
    try {
      await _firestore
          .collection('users')
          .doc(id)
          .collection('apiCredentials')
          .doc(DocumentName.bbApiCredential.name)
          .update(bbCredentials.toMap());
    } on FirebaseException catch (e) {
      final errorMessage = await _firebaseFirestoreErrorHandler(e);
      throw ErrorUpdateApiCredentials(message: errorMessage);
    } catch (e) {
      await _sendLogsToWeb(e);
      _registerLog(e);
      throw ErrorUpdateApiCredentials(
        message: 'Ocorreu um erro ao atualizar os dados. Tente novamente',
      );
    }
  }

  @override
  Future<void> deleteBBApiCredentials({
    required String id,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(id)
          .collection('apiCredentials')
          .doc(DocumentName.bbApiCredential.name)
          .delete();
    } on FirebaseException catch (e) {
      final errorMessage = await _firebaseFirestoreErrorHandler(e);
      throw ErrorRemovingApiCredentials(message: errorMessage);
    } catch (e) {
      await _sendLogsToWeb(e);
      _registerLog(e);
      throw ErrorRemovingApiCredentials(
        message: 'Ocorreu um erro ao remover os dados. tente novamente',
      );
    }
  }

  @override
  Future<void> saveSicoobApiCredentials({
    required String id,
    required String clientID,
    required String certificatePassword,
    required String certificateBase64String,
    required bool isFavorite,
  }) async {
    final key = _dataCrypto.generateKey(userId: id);
    final encryptedClientID = _dataCrypto.encrypt(
      plainText: clientID,
      key: key,
    );
    final encryptedCertificateBase64String = _dataCrypto.encrypt(
      plainText: certificateBase64String,
      key: key,
    );
    final encryptedCertificatePassword = _dataCrypto.encrypt(
      plainText: certificatePassword,
      key: key,
    );
    final sicoobCredentials = SicoobApiCredentialsModel(
      clientID: encryptedClientID,
      certificateBase64String: encryptedCertificateBase64String,
      certificatePassword: encryptedCertificatePassword,
      isFavorite: isFavorite,
    );
    try {
      await _firestore
          .collection('users')
          .doc(id)
          .collection('apiCredentials')
          .doc(DocumentName.sicoobApiCredential.name)
          .set(sicoobCredentials.toMap());
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
  Future<SicoobApiCredentialsModel?> readSicoobApiCredentials({
    required String id,
  }) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(id)
          .collection('apiCredentials')
          .doc(DocumentName.sicoobApiCredential.name)
          .get();
      final data = doc.data();
      if (doc.exists) {
        if (data != null) {
          final key = _dataCrypto.generateKey(userId: id);
          final decryptedClientID = _dataCrypto.decrypt(
            cipherText: data['clientID'],
            key: key,
          );
          final decryptedCertificateBase64String = _dataCrypto.decrypt(
            cipherText: data['certificateBase64String'],
            key: key,
          );
          final decryptedCertificatePassword = _dataCrypto.decrypt(
            cipherText: data['certificatePassword'],
            key: key,
          );
          final clientID = decryptedClientID;
          final certificatePassword = decryptedCertificatePassword;
          final certificateBase64String = decryptedCertificateBase64String;
          final isFavorite = data['isFavorite'];
          return SicoobApiCredentialsModel(
            clientID: clientID,
            certificatePassword: certificatePassword,
            certificateBase64String: certificateBase64String,
            isFavorite: isFavorite,
          );
        } else {
          return null;
        }
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      final errorMessage = await _firebaseFirestoreErrorHandler(e);
      throw ErrorReadingApiCredentials(message: errorMessage);
    } catch (e) {
      await _sendLogsToWeb(e);
      _registerLog(e);
      throw ErrorReadingApiCredentials(
        message: 'Ocorreu um erro ao recuperar os dados. tente novamente',
      );
    }
  }

  @override
  Future<void> updateSicoobApiCredentials({
    required String id,
    required String clientID,
    required String certificatePassword,
    required String certificateBase64String,
    required bool isFavorite,
  }) async {
    final key = _dataCrypto.generateKey(userId: id);
    final encryptedClientID = _dataCrypto.encrypt(
      plainText: clientID,
      key: key,
    );
    final encryptedCertificateBase64String = _dataCrypto.encrypt(
      plainText: certificateBase64String,
      key: key,
    );
    final encryptedCertificatePassword = _dataCrypto.encrypt(
      plainText: certificatePassword,
      key: key,
    );
    final sicoobCredentials = SicoobApiCredentialsModel(
      clientID: encryptedClientID,
      certificateBase64String: encryptedCertificateBase64String,
      certificatePassword: encryptedCertificatePassword,
      isFavorite: isFavorite,
    );
    try {
      await _firestore
          .collection('users')
          .doc(id)
          .collection('apiCredentials')
          .doc(DocumentName.sicoobApiCredential.name)
          .update(sicoobCredentials.toMap());
    } on FirebaseException catch (e) {
      final errorMessage = await _firebaseFirestoreErrorHandler(e);
      throw ErrorUpdateApiCredentials(message: errorMessage);
    } catch (e) {
      await _sendLogsToWeb(e);
      _registerLog(e);
      throw ErrorUpdateApiCredentials(
        message: 'Ocorreu um erro ao atualizar os dados. Tente novamente',
      );
    }
  }

  @override
  Future<void> deleteSicoobApiCredentials({
    required String id,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(id)
          .collection('apiCredentials')
          .doc(DocumentName.sicoobApiCredential.name)
          .delete();
    } on FirebaseException catch (e) {
      final errorMessage = await _firebaseFirestoreErrorHandler(e);
      throw ErrorRemovingApiCredentials(message: errorMessage);
    } catch (e) {
      await _sendLogsToWeb(e);
      _registerLog(e);
      throw ErrorRemovingApiCredentials(
        message: 'Ocorreu um erro ao remover os dados. tente novamente',
      );
    }
  }
}
