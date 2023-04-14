import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:verify/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:verify/app/modules/auth/infra/datasource/auth_datasource.dart';
import 'package:verify/app/modules/auth/infra/models/user_model.dart';
import 'package:verify/app/modules/auth/infra/repositories/auth_repository_impl.dart';

class LoginDataSourceMock extends Mock implements AuthDataSource {}

class UserModelMock extends Mock implements UserModel {}

void main() {
  late AuthRepository authRepository;
  late AuthDataSource authDataSource;
  late UserModelMock userModel;
  const email = 'example@example.com';
  const password = '12345678';
  setUp(() {
    authDataSource = LoginDataSourceMock();
    authRepository = AuthRepositoryImpl(authDataSource);
    userModel = UserModelMock();
    registerFallbackValue(userModel);
  });

  group('AuthRepository: ', () {
    test('Should call logout method from repository', () async {
      when(() => authDataSource.logout()).thenAnswer((_) async {});

      await authRepository.logout();

      verify(() => authDataSource.logout()).called(1);
    });

    test('Should return a UserModel when retrieving current logged in user',
        () async {
      when(() => authDataSource.currentUser()).thenAnswer(
        (_) async => userModel,
      );

      final user = await authRepository.loggedUser();
      final result = user.getOrNull();
      expect(result, isNotNull);
    });

    test('Shoud return UserModel if login with email is successful', () async {
      when(() => authDataSource.loginWithEmail(
          email: any(named: 'email'),
          password: any(named: 'password'))).thenAnswer((_) async => userModel);

      final response = await authRepository.loginWithEmail(
        email: email,
        password: password,
      );

      final result = response.getOrNull();
      expect(result, isNotNull);
    });
    test('Shoud return Failure if login with email is unsuccessful', () async {
      when(() => authDataSource.loginWithEmail(
          email: any(named: 'email'),
          password: any(named: 'password'))).thenThrow(Exception());

      final response = await authRepository.loginWithEmail(
        email: email,
        password: password,
      );

      final result = response.exceptionOrNull();
      expect(result, isNotNull);
    });

    test('Shoud return UserModel if login with Google is successful', () async {
      when(() => authDataSource.loginWithGoogle()).thenAnswer(
        (_) async => userModel,
      );
      final response = await authRepository.loginWithGoogle();

      final result = response.getOrNull();
      expect(result, isNotNull);
    });

    test('Shoud return UserModel if login with Google is unsuccessful',
        () async {
      when(() => authDataSource.loginWithGoogle()).thenThrow(Exception());
      final response = await authRepository.loginWithGoogle();

      final result = response.exceptionOrNull();
      expect(result, isNotNull);
    });
    test('Verify called sendRecoverInstructions', () async {
      when(() => authDataSource.sendRecoverInstructions(
          email: any(named: 'email'))).thenAnswer((_) async {});

      await authRepository.sendRecoverInstructions(email: email);

      verify(() => authDataSource.sendRecoverInstructions(
          email: any(named: 'email'))).called(1);
    });
  });
}
