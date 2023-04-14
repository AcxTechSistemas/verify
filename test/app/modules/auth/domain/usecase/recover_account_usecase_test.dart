import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:verify/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:verify/app/modules/auth/domain/usecase/recover_account_usecase.dart';
import 'package:result_dart/result_dart.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthRepository authRepository;
  late RecoverAccountUseCase recoverAccountUseCase;
  setUp(() {
    authRepository = MockAuthRepository();
    recoverAccountUseCase = RecoverAccountUseCaseImpl(authRepository);
  });
  group('RecoverAccountUseCase: ', () {
    test('Verify called sendRecoverInstructions ', () async {
      const email = 'test@example.com';

      when(
        () =>
            authRepository.sendRecoverInstructions(email: any(named: 'email')),
      ).thenAnswer((_) async => const Success(Void));

      await recoverAccountUseCase(email: email);

      verify(
        () =>
            authRepository.sendRecoverInstructions(email: any(named: 'email')),
      ).called(1);
    });
  });
}
