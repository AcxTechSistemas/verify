import 'package:verify/app/features/auth/infra/models/user_model.dart';

abstract class AuthDataSource {
  Future<UserModel> currentUser();
  Future<UserModel> registerWithEmail({
    required String email,
    required String password,
  });
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  });
  Future<UserModel> loginWithGoogle();
  Future<void> logout();
}
