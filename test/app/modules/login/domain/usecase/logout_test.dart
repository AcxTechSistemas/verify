import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:verify/app/modules/login/domain/repositories/login_repository.dart';
import 'package:verify/app/modules/login/domain/usecase/logout.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}

void main() {
  late LoginRepository loginRepository;
  late LogoutUseCase logoutUseCase;
  setUp(() {
    loginRepository = LoginRepositoryMock();
    logoutUseCase = LogoutUseCaseImpl(loginRepository);
  });
  test('Should call logout method from repository', () async {
    when(() => loginRepository.logout()).thenAnswer((_) async {});

    await logoutUseCase();

    verify(() => loginRepository.logout()).called(1);
  });
}
