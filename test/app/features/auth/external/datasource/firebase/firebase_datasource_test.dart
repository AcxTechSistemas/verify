import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:verify/app/core/register_log.dart';
import 'package:verify/app/core/send_logs_to_web.dart';
import 'package:verify/app/features/auth/domain/errors/auth_error.dart';
import 'package:verify/app/features/auth/external/datasource/firebase/errors/firebase_auth_error_handler.dart';
import 'package:verify/app/features/auth/external/datasource/firebase/firebase_datasource_impl.dart';
import 'package:verify/app/features/auth/infra/datasource/auth_datasource.dart';
import 'package:verify/app/features/auth/infra/models/user_model.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockFirebaseErrorHandler extends Mock
    implements FirebaseAuthErrorHandler {}

class MockUser extends Mock implements User {}

class MockUserCredential extends Mock implements UserCredential {}

class MockRegisterLog extends Mock implements RegisterLog {}

class MockSendLogsToWeb extends Mock implements SendLogsToWeb {}

void main() {
  late MockFirebaseAuth firebaseAuth;

  late MockGoogleSignIn googleSignIn;
  late FirebaseAuthErrorHandler firebaseErrorHandler;

  late AuthDataSource dataSource;
  late MockUser user;
  late RegisterLog registerLog;
  late SendLogsToWeb sendLogsToWeb;

  setUpAll(() {
    firebaseErrorHandler = MockFirebaseErrorHandler();
    firebaseAuth = MockFirebaseAuth();

    googleSignIn = MockGoogleSignIn();

    registerLog = MockRegisterLog();
    sendLogsToWeb = MockSendLogsToWeb();
    dataSource = FirebaseDataSourceImpl(
      firebaseAuth,
      googleSignIn,
      firebaseErrorHandler,
      registerLog,
      sendLogsToWeb,
    );
    user = MockUser();
    when(() => sendLogsToWeb(any())).thenAnswer((_) async {});
  });

  group('FirebaseDatasource: ', () {
    test('should return UserModel when currentUser succeeds', () async {
      when(() => firebaseAuth.currentUser).thenReturn(user);
      when(() => user.uid).thenReturn('userID');
      when(() => user.email).thenReturn('test@test.com');
      when(() => user.displayName).thenReturn('Test User');
      when(() => user.emailVerified).thenReturn(true);

      final result = await dataSource.currentUser();

      expect(
        result,
        equals(UserModel(
          id: 'userID',
          email: 'test@test.com',
          name: 'Test User',
          emailVerified: user.emailVerified,
        )),
      );
    });

    test('should throw ErrorGetLoggedUser when currentUser fails', () async {
      when(() => firebaseAuth.currentUser).thenReturn(null);

      final future = dataSource.currentUser();

      expect(future, throwsA(isInstanceOf<ErrorGetLoggedUser>()));
    });

    test(
        'should throw an ErrorLoginEmail when login fails due to FirebaseAuthException',
        () async {
      const email = 'test@test.com';
      const password = '123456';
      final exception = FirebaseAuthException(
          code: 'invalid-email',
          message: 'The email address is badly formatted.');

      when(() => firebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          )).thenThrow(exception);

      when(() => firebaseErrorHandler(exception)).thenAnswer(
        (_) async => 'The email address is badly formatted.',
      );

      expect(() => dataSource.loginWithEmail(email: email, password: password),
          throwsA(isA<ErrorLoginEmail>()));

      verify(() => firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password)).called(1);
    });

    test('should throw an Exception when login fails due to an unknown error',
        () async {
      const email = 'test@test.com';
      const password = '123456';

      when(() => firebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          )).thenThrow(Exception('Unknown error'));

      expect(() => dataSource.loginWithEmail(email: email, password: password),
          throwsException);

      verify(() => firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password)).called(1);
    });

    test('Verify called sendPasswordResetEmail', () async {
      const email = 'test@example.com';

      when(() =>
              firebaseAuth.sendPasswordResetEmail(email: any(named: 'email')))
          .thenAnswer((_) async {});

      await dataSource.sendRecoverInstructions(email: email);

      verify(() =>
              firebaseAuth.sendPasswordResetEmail(email: any(named: 'email')))
          .called(1);
    });
  });
}
