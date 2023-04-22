// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:verify/app/shared/error_registrator/register_log.dart';
import 'package:verify/app/shared/error_registrator/send_logs_to_web.dart';

import 'package:verify/app/modules/auth/domain/errors/auth_error.dart';
import 'package:verify/app/modules/auth/external/datasource/firebase/error_handler/firebase_auth_error_handler.dart';
import 'package:verify/app/modules/auth/infra/datasource/auth_datasource.dart';
import 'package:verify/app/modules/auth/infra/models/user_model.dart';

class FirebaseDataSourceImpl implements AuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseAuthErrorHandler _firebaseAuthErrorHandler;
  final RegisterLog _registerLog;
  final SendLogsToWeb _sendLogsToWeb;
  FirebaseDataSourceImpl(
    this._firebaseAuth,
    this._googleSignIn,
    this._firebaseAuthErrorHandler,
    this._registerLog,
    this._sendLogsToWeb,
  );

  @override
  Future<UserModel?> currentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        return UserModel(
          id: user.uid,
          email: user.email!,
          name: user.displayName ?? '',
          emailVerified: user.emailVerified,
        );
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      final errorMessage = await _firebaseAuthErrorHandler(e);
      throw ErrorGetLoggedUser(message: errorMessage);
    } catch (e) {
      await _sendLogsToWeb(e);
      _registerLog(e);
      throw ErrorGetLoggedUser(
        message: 'Token expirado. \nPor favor, faça login novamente.',
      );
    }
  }

  @override
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user!;
      if (!user.emailVerified) {
        await _sendEmailVerification(user);
      }
      return UserModel(
        id: user.uid,
        email: user.email!,
        name: user.displayName ?? '',
        emailVerified: user.emailVerified,
      );
    } on FirebaseAuthException catch (e) {
      final errorMessage = await _firebaseAuthErrorHandler(e);
      throw ErrorLoginEmail(message: errorMessage);
    } catch (e) {
      await _sendLogsToWeb(e);
      _registerLog(e);
      throw Exception('Ocorreu um erro ao realizar o login. Tente novamente');
    }
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      final user = userCredential.user!;

      return UserModel(
        id: user.uid,
        email: user.email!,
        name: user.displayName!,
        emailVerified: user.emailVerified,
      );
    } on FirebaseAuthException catch (e) {
      final errorMessage = await _firebaseAuthErrorHandler(e);
      throw ErrorGoogleLogin(message: errorMessage);
    } catch (e) {
      await _sendLogsToWeb(e);
      _registerLog(e);
      throw Exception('Ocorreu um erro ao realizar o login. Tente novamente');
    }
  }

  @override
  Future<UserModel> registerWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user!;
      await _sendEmailVerification(user);
      return UserModel(
        id: user.uid,
        email: user.email!,
        name: user.displayName ?? '',
        emailVerified: user.emailVerified,
      );
    } on FirebaseAuthException catch (e) {
      final errorMessage = await _firebaseAuthErrorHandler(e);
      throw ErrorRegisterEmail(message: errorMessage);
    } catch (e) {
      await _sendLogsToWeb(e);
      _registerLog(e);
      throw Exception(
        'Ocorreu um erro ao criar uma nova conta. Tente novamente',
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      final errorMessage = await _firebaseAuthErrorHandler(e);
      throw ErrorLogout(message: errorMessage);
    } catch (e) {
      await _sendLogsToWeb(e);
      _registerLog(e);
      throw Exception(
        'Ocorreu um erro ao deslogar, tente novamente',
      );
    }
  }

  @override
  Future<void> sendRecoverInstructions({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      final errorMessage = await _firebaseAuthErrorHandler(e);
      throw ErrorRecoverAccount(message: errorMessage);
    } catch (e) {
      await _sendLogsToWeb(e);
      _registerLog(e);
      throw Exception(
        'Ocorreu um erro ao recuperar sua conta. Tente novamente',
      );
    }
  }

  Future<void> _sendEmailVerification(User user) async {
    try {
      await user.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      final errorMessage = await _firebaseAuthErrorHandler(e);
      throw ErrorSendingEmailVerification(message: errorMessage);
    } catch (e) {
      await _sendLogsToWeb(e);
      _registerLog(e);
      throw ErrorSendingEmailVerification(
        message:
            'Ocorreu um erro ao enviar o email de verificação, Tente novamente mais tarde',
      );
    }
  }
}
