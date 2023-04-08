import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:verify/app/modules/login/domain/repositories/login_repository.dart';
import 'package:verify/app/modules/login/infra/datasource/login_datasource.dart';
import 'package:verify/app/modules/login/infra/models/user_model.dart';
import 'package:verify/app/modules/login/infra/repositories/login_repository_impl.dart';

class LoginDataSourceMock extends Mock implements LoginDataSource {}

class UserModelMock extends Mock implements UserModel {}

void main() {
  late LoginRepository loginRepository;
  late LoginDataSource loginDataSource;
  late UserModelMock userModel;
  const email = 'example@example.com';
  const password = '12345678';
  setUp(() {
    loginDataSource = LoginDataSourceMock();
    loginRepository = LoginRepositoryImpl(loginDataSource);
    userModel = UserModelMock();
    registerFallbackValue(userModel);
  });

  group('LoginRepository: ', () {
    test('Should call logout method from repository', () async {
      when(() => loginDataSource.logout()).thenAnswer((_) async {});

      await loginRepository.logout();

      verify(() => loginDataSource.logout()).called(1);
    });

    test('Should return a UserModel when retrieving current logged in user',
        () async {
      when(() => loginDataSource.currentUser()).thenAnswer(
        (_) async => userModel,
      );

      final user = await loginRepository.loggedUser();
      final result = user.getOrNull();
      expect(result, isNotNull);
    });

    test('Shoud return UserModel if login with email is successful', () async {
      when(() => loginDataSource.loginWithEmail(
          email: any(named: 'email'),
          password: any(named: 'password'))).thenAnswer((_) async => userModel);

      final response = await loginRepository.loginWithEmail(
        email: email,
        password: password,
      );

      final result = response.getOrNull();
      expect(result, isNotNull);
    });
    test('Shoud return Failure if login with email is unsuccessful', () async {
      when(() => loginDataSource.loginWithEmail(
          email: any(named: 'email'),
          password: any(named: 'password'))).thenThrow(Exception());

      final response = await loginRepository.loginWithEmail(
        email: email,
        password: password,
      );

      final result = response.exceptionOrNull();
      expect(result, isNotNull);
    });

    test('Shoud return UserModel if login with Google is successful', () async {
      when(() => loginDataSource.loginWithGoogle()).thenAnswer(
        (_) async => userModel,
      );
      final response = await loginRepository.loginWithGoogle();

      final result = response.getOrNull();
      expect(result, isNotNull);
    });

    test('Shoud return UserModel if login with Google is unsuccessful',
        () async {
      when(() => loginDataSource.loginWithGoogle()).thenThrow(Exception());
      final response = await loginRepository.loginWithGoogle();

      final result = response.exceptionOrNull();
      expect(result, isNotNull);
    });
  });
}
