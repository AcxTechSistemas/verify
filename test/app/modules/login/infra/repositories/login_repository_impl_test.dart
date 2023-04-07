import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:verify/app/modules/login/domain/entities/login_credentials_entity.dart';
import 'package:verify/app/modules/login/domain/repositories/login_repository.dart';
import 'package:verify/app/modules/login/infra/datasource/login_datasource.dart';
import 'package:verify/app/modules/login/infra/models/user_model.dart';
import 'package:verify/app/modules/login/infra/repositories/login_repository_impl.dart';

class LoginDataSourceMock extends Mock implements LoginDataSource {}

class UserModelMock extends Mock implements UserModel {}

class LoginCredentialsEntityMock extends Mock
    implements LoginCredentialsEntity {}

void main() {
  late LoginRepository loginRepository;
  late LoginDataSource loginDataSource;
  late UserModelMock userModel;
  late LoginCredentialsEntity loginCredentialsEntity;
  setUp(() {
    loginDataSource = LoginDataSourceMock();
    loginRepository = LoginRepositoryImpl(loginDataSource);
    userModel = UserModelMock();
    loginCredentialsEntity = LoginCredentialsEntityMock();
    registerFallbackValue(userModel);
    registerFallbackValue(loginCredentialsEntity);
  });

  group('LoginRepository: ', () {
    test('Shoud return UserModel if login with email is successful', () async {
      when(() => loginDataSource.loginWithEmail(any())).thenAnswer(
        (_) async => userModel,
      );
      final response = await loginRepository.loginWithEmail(
        loginCredentialsEntity,
      );

      final result = response.getOrNull();
      expect(result, isNotNull);
    });
    test('Shoud return Failure if login with email is unsuccessful', () async {
      when(() => loginDataSource.loginWithEmail(any())).thenThrow(Exception());
      final response = await loginRepository.loginWithEmail(
        loginCredentialsEntity,
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
