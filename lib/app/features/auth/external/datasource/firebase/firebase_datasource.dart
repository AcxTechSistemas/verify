// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:verify/app/features/auth/domain/errors/auth_error.dart';
import 'package:verify/app/features/auth/external/datasource/firebase/errors/firebase_error_handler.dart';
import 'package:verify/app/features/auth/infra/datasource/auth_datasource.dart';
import 'package:verify/app/features/auth/infra/models/user_model.dart';

class FirebaseDataSourceImpl implements AuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  FirebaseDataSourceImpl(
    this._firebaseAuth,
    this._googleSignIn,
  );

  @override
  Future<UserModel> currentUser() async {
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      throw ErrorGetLoggedUser(message: 'Token de acesso expirado');
    }

    return UserModel(
      email: user.email!,
      name: user.displayName ?? '',
      emailVerified: user.emailVerified,
    );
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
      await _sendEmailVerification(user);
      return UserModel(
        email: user.email!,
        name: user.displayName ?? '',
        emailVerified: user.emailVerified,
      );
    } on FirebaseAuthException catch (e) {
      final errorHandler = FirebaseErrorHandler();
      final errorMessage = errorHandler(e);
      throw ErrorLoginEmail(message: errorMessage);
    } catch (e) {
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
        email: user.email!,
        name: user.displayName!,
        emailVerified: user.emailVerified,
      );
    } on FirebaseAuthException catch (e) {
      final errorHandler = FirebaseErrorHandler();
      final errorMessage = errorHandler(e);
      throw ErrorGoogleLogin(message: errorMessage);
    } catch (e) {
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
      await user.sendEmailVerification();
      return UserModel(
        email: user.email!,
        name: user.displayName ?? '',
        emailVerified: user.emailVerified,
      );
    } on FirebaseAuthException catch (e) {
      final errorHandler = FirebaseErrorHandler();
      final errorMessage = errorHandler(e);
      throw ErrorRegisterEmail(message: errorMessage);
    } catch (e) {
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
      final errorHandler = FirebaseErrorHandler();
      final errorMessage = errorHandler(e);
      throw ErrorLogout(message: errorMessage);
    } catch (e) {
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
      final errorHandler = FirebaseErrorHandler();
      final errorMessage = errorHandler(e);
      throw ErrorRecoverAccount(message: errorMessage);
    } catch (e) {
      throw Exception(
        'Ocorreu um erro ao recuperar sua conta. Tente novamente',
      );
    }
  }

  Future<void> _sendEmailVerification(User user) async {
    try {
      await user.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      final errorHandler = FirebaseErrorHandler();
      final errorMessage = errorHandler(e);
      throw ErrorSendingEmailVerification(message: errorMessage);
    } catch (e) {
      throw ErrorSendingEmailVerification(
        message:
            'Ocorreu um erro ao enviar o email de verificação, Tente novamente mais tarde',
      );
    }
  }
}
