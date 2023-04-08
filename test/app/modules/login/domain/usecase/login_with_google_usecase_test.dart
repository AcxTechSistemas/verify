import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/login/domain/entities/logged_user_info.dart';
import 'package:verify/app/modules/login/domain/errors/login_error.dart';
import 'package:verify/app/modules/login/domain/repositories/login_repository.dart';
import 'package:verify/app/modules/login/domain/usecase/login_with_google_usecase.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}

void main() {
  late LoginRepository loginRepository;
  late LoginWithGoogleUseCase loginWithGoogleUseCase;
  setUp(() {
    loginRepository = LoginRepositoryMock();
    loginWithGoogleUseCase = LoginWithGoogleImpl(loginRepository);
  });
  group('LoginWithGoogleUseCase: ', () {
    test(
      'Should return instance of LoggedUserInfo if login is successful',
      () async {
        final expectedResponse = LoggedUserInfoEntity(
          name: 'Antonio',
          email: 'example@example.com',
        );
        when(() => loginRepository.loginWithGoogle())
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
        when(() => loginRepository.loginWithGoogle()).thenAnswer(
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
