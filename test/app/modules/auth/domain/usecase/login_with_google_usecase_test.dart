import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/auth/domain/entities/logged_user_info.dart';
import 'package:verify/app/modules/auth/domain/errors/auth_error.dart';
import 'package:verify/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:verify/app/modules/auth/domain/usecase/login_with_google_usecase.dart';

class AuthRepositoryMock extends Mock implements AuthRepository {}

void main() {
  late AuthRepository authRepository;
  late LoginWithGoogleUseCase loginWithGoogleUseCase;
  setUp(() {
    authRepository = AuthRepositoryMock();
    loginWithGoogleUseCase = LoginWithGoogleImpl(authRepository);
  });
  group('LoginWithGoogleUseCase: ', () {
    test(
      'Should return instance of LoggedUserInfo if login is successful',
      () async {
        final expectedResponse = LoggedUserInfoEntity(
          name: 'Antonio',
          email: 'example@example.com',
          emailVerified: false,
        );
        when(() => authRepository.loginWithGoogle())
            .thenAnswer((_) async => Success(expectedResponse));
        final response = await loginWithGoogleUseCase();

        final result = response.getOrNull();

        expect(result, isNotNull);
        expect(result!.email, equals('example@example.com'));
      },
    );
    test(
      'Should return instance of ErrorLogin if login is successful',
      () async {
        const expectErrorMessage = 'invalid-account';
        when(() => authRepository.loginWithGoogle()).thenAnswer(
          (_) async => Failure(ErrorGoogleLogin(message: expectErrorMessage)),
        );

        final response = await loginWithGoogleUseCase();

        final result = response.exceptionOrNull();

        expect(result, isNotNull);
        expect(result!.message, equals(expectErrorMessage));
      },
    );
  });
}
