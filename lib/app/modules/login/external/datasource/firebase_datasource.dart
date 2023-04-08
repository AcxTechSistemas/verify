// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:verify/app/modules/login/domain/errors/login_error.dart';
import 'package:verify/app/modules/login/infra/datasource/login_datasource.dart';
import 'package:verify/app/modules/login/infra/models/user_model.dart';

class FirebaseDataSource implements LoginDataSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  FirebaseDataSource(
    this._firebaseAuth,
    this._googleSignIn,
  );

  @override
  Future<UserModel> currentUser() async {
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      throw ErrorGetLoggedUser(message: 'User don\'t have valid token');
    }

    return UserModel(
      email: user.email!,
      name: user.displayName ?? '',
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

      return UserModel(email: user.email!, name: user.displayName ?? '');
    } on FirebaseException catch (e) {
      throw ErrorLoginEmail(
        message: 'FirebaseError: code: ${e.code} message ${e.message ?? ''}',
      );
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

      return UserModel(email: user.email!, name: user.displayName!);
    } on FirebaseException catch (e) {
      throw ErrorGoogleLogin(
        message: 'FirebaseError: code: ${e.code} message ${e.message ?? ''}',
      );
    }
  }

  @override
  Future<void> logout() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
