import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/auth/domain/errors/auth_error.dart';
import 'package:verify/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:verify/app/modules/auth/domain/usecase/logout_usecase.dart';

class AuthRepositoryMock extends Mock implements AuthRepository {}

void main() {
  late AuthRepository authRepository;
  late LogoutUseCase logoutUseCase;
  setUp(() {
    authRepository = AuthRepositoryMock();
    logoutUseCase = LogoutUseCaseImpl(authRepository);
  });

  group('LogoutUseCase: ', () {
    test(
      'Should call logout method from repository',
      () async {
        when(() => authRepository.logout()).thenAnswer(
          (_) async => const Success(Void),
        );

        final loggedOut = await logoutUseCase();

        verify(() => authRepository.logout()).called(1);

        expect(loggedOut.isSuccess(), true);
      },
    );
    test(
      'Should return ErrorLogout if failure',
      () async {
        when(() => authRepository.logout()).thenAnswer(
          (_) async => Failure(ErrorLogout(message: 'error in logout')),
        );

        final loggedOut = await logoutUseCase();

        verify(() => authRepository.logout()).called(1);

        expect(loggedOut.isError(), true);
      },
    );
  });
}
