import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/auth/domain/entities/logged_user_info.dart';
import 'package:verify/app/modules/auth/domain/entities/login_credentials_entity.dart';
import 'package:verify/app/modules/auth/domain/errors/auth_error.dart';
import 'package:verify/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:verify/app/modules/auth/domain/usecase/login_with_email_usecase.dart';

class AuthRepositoryMock extends Mock implements AuthRepository {}

void main() {
  late AuthRepository authRepository;
  late LoginWithEmailUseCase loginWithEmailUseCase;

  setUp(() {
    authRepository = AuthRepositoryMock();
    loginWithEmailUseCase = LoginWithEmailUseCaseImpl(authRepository);
  });

  group('LoginWithEmailUseCase: ', () {
    test(
      'Should return instance of LoggedUserInfo if login is successful',
      () async {
        final expectedResponse = LoggedUserInfoEntity(
          id: 'id',
          name: 'Antonio',
          email: 'example@example.com',
          emailVerified: false,
        );
        final loginCredentialsEntity = LoginCredentialsEntity(
          email: 'example@example.com',
          password: '12345678',
        );

        registerFallbackValue(loginCredentialsEntity);

        when(() => authRepository.loginWithEmail(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => Success(expectedResponse));

        final response = await loginWithEmailUseCase(
          loginCredentialsEntity,
        );

        final result = response.getOrNull();

        expect(result, isNotNull);
        expect(result!.name, contains('Antonio'));
        expect(result.email, equals('example@example.com'));
      },
    );
    test(
      'Should return instance of ErrorLoginEmail if the email is invalid',
      () async {
        final expectedResponse = LoggedUserInfoEntity(
          id: 'id',
          name: 'Antonio',
          email: 'example@example.com',
          emailVerified: false,
        );

        final loginCredentialsEntity = LoginCredentialsEntity(
          email: 'exampleexample.com',
          password: '12345678',
        );

        const expectErrorMessage = 'invalid-email';

        registerFallbackValue(loginCredentialsEntity);
        when(() => authRepository.loginWithEmail(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenAnswer(
          (_) async => Success(expectedResponse),
        );

        final response = await loginWithEmailUseCase(
          loginCredentialsEntity,
        );

        final result = response.exceptionOrNull();

        expect(result, isNotNull);
        expect(result, isA<ErrorLoginEmail>());
        expect(result!.message, equals(expectErrorMessage));
      },
    );
    test(
      'Should return instance of ErrorLoginEmail if the password is invalid',
      () async {
        final expectedResponse = LoggedUserInfoEntity(
          id: 'id',
          name: 'Antonio',
          email: 'example@example.com',
          emailVerified: false,
        );

        final loginCredentialsEntity = LoginCredentialsEntity(
          email: 'example@example.com',
          password: '1234567',
        );

        const expectErrorMessage = 'invalid-password';

        registerFallbackValue(loginCredentialsEntity);
        when(() => authRepository.loginWithEmail(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenAnswer(
          (_) async => Success(expectedResponse),
        );

        final response = await loginWithEmailUseCase(
          loginCredentialsEntity,
        );

        final result = response.exceptionOrNull();

        expect(result, isNotNull);
        expect(result, isA<ErrorLoginEmail>());
        expect(result!.message, equals(expectErrorMessage));
      },
    );
  });
}
