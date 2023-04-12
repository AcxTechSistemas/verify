import 'package:flutter_test/flutter_test.dart';
import 'package:verify/app/features/auth/domain/entities/login_credentials_entity.dart';

void main() {
  group('LoginCredentialsEntity: ', () {
    test('Should return true if email is valid', () {
      final entity = LoginCredentialsEntity(
        email: 'example@example.com',
        password: '123456789',
      );
      expect(entity.isValidEmail, true);
    });
    test('Should return false if email is invalid', () {
      final entity = LoginCredentialsEntity(
        email: 'exampleexample.com',
        password: '123456789',
      );
      expect(entity.isValidEmail, false);
    });
    test('Should return true if password is valid', () {
      final entity = LoginCredentialsEntity(
        email: 'example@example.com',
        password: '123456789',
      );
      expect(entity.isValidPassword, true);
    });
    test('Should return false if password is invalid', () {
      final entity = LoginCredentialsEntity(
        email: 'example@example.com',
        password: '1234567',
      );
      expect(entity.isValidPassword, false);
    });
  });
}
