import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:verify/app/features/auth/domain/errors/auth_error.dart';
import 'package:verify/app/features/auth/external/datasource/firebase/firebase_datasource.dart';
import 'package:verify/app/features/auth/infra/datasource/auth_datasource.dart';
import 'package:verify/app/features/auth/infra/models/user_model.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockUser extends Mock implements User {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late MockFirebaseAuth firebaseAuth;
  late UserCredential userCredential;

  ///
  late MockGoogleSignIn googleSignIn;

  ///
  late AuthDataSource dataSource;
  late MockUser user;

  setUpAll(() {
    firebaseAuth = MockFirebaseAuth();
    userCredential = MockUserCredential();

    ///
    googleSignIn = MockGoogleSignIn();

    ///
    dataSource = FirebaseDataSourceImpl(
      firebaseAuth,
      googleSignIn,
    );
    user = MockUser();
  });

  test('should return UserModel when currentUser succeeds', () async {
    when(() => firebaseAuth.currentUser).thenReturn(user);
    when(() => user.email).thenReturn('test@test.com');
    when(() => user.displayName).thenReturn('Test User');
    when(() => user.emailVerified).thenReturn(true);

    final result = await dataSource.currentUser();

    expect(
      result,
      equals(UserModel(
        email: 'test@test.com',
        name: 'Test User',
        validEmail: user.emailVerified,
      )),
    );
  });

  test('should throw ErrorGetLoggedUser when currentUser fails', () async {
    when(() => firebaseAuth.currentUser).thenReturn(null);

    final future = dataSource.currentUser();

    expect(future, throwsA(isInstanceOf<ErrorGetLoggedUser>()));
  });

  test('should return UserModel when loginWithEmail succeeds', () async {
    const email = 'test@test.com';
    const password = '123456';

    when(() => userCredential.user).thenReturn(user);
    when(() => user.email).thenReturn(email);
    when(() => user.displayName).thenReturn('Test User');
    when(() => firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        )).thenAnswer((_) async => userCredential);

    final response =
        await dataSource.loginWithEmail(email: email, password: password);

    expect(
        response,
        equals(UserModel(
          email: email,
          name: 'Test User',
          validEmail: user.emailVerified,
        )));
  });

  test('should throw ErrorLoginEmail when loginWithEmail fails', () async {
    // arrange
    const email = 'test@test.com';
    const password = '123456';
    final exception = FirebaseException(
      code: 'ERROR_INVALID_EMAIL',
      message: 'Invalid email address',
      plugin: '',
    );

    when(() => firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password)).thenThrow(exception);

    final future = dataSource.loginWithEmail(email: email, password: password);

    expect(future, throwsA(isInstanceOf<ErrorLoginEmail>()));
  });
}
