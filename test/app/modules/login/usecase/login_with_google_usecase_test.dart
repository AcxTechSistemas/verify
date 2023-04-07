import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/login/entities/logged_user_info.dart';
import 'package:verify/app/modules/login/errors/login_error.dart';
import 'package:verify/app/modules/login/repositories/login_with_google_repository.dart';

class LoginWithGoogleRepositoryMock extends Mock
    implements LoginWithGoogleRepository {}

void main() {
  late LoginWithGoogleRepository loginWithGoogleRepository;

  setUp(() {
    loginWithGoogleRepository = LoginWithGoogleRepositoryMock();
  });
  test(
    'Should return instance of LoggedUserInfo if login is successful',
    () async {
      final expectedResponse = LoggedUserInfoEntity(
        name: 'Antonio',
        email: 'example@example.com',
      );
      when(() => loginWithGoogleRepository())
          .thenAnswer((_) async => Success(expectedResponse));
      final response = await loginWithGoogleRepository();

      final result = response.getOrNull();

      expect(result, isNotNull);
      expect(result!.email, equals('example@example.com'));
    },
  );
  test(
    'Should return instance of ErrorLogin if login is successful',
    () async {
      when(() => loginWithGoogleRepository()).thenAnswer(
        (_) async => Failure(ErrorGoogleLogin(message: 'invalid-account')),
      );

      final response = await loginWithGoogleRepository();

      final result = response.exceptionOrNull();

      expect(result, isNotNull);
      expect(result!.message, equals('invalid-account'));
    },
  );
}
