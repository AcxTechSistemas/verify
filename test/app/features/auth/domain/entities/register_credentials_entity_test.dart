import 'package:flutter_test/flutter_test.dart';
import 'package:verify/app/features/auth/domain/entities/register_credentials_entity.dart';

void main() {
  group('RegisterCredentialsEntity: ', () {
    test('Should return true if email is valid', () {
      final entity = RegisterCredentialsEntity(
        email: 'example@example.com',
        password: '123456789',
        confirmPassword: '123456789',
      );
      expect(entity.isValidEmail, true);
    });
    test('Should return false if email is invalid', () {
      final entity = RegisterCredentialsEntity(
        email: 'exampleexample.com',
        password: '123456789',
        confirmPassword: '123456789',
      );
      expect(entity.isValidEmail, false);
    });
    test('Should return true if password is valid', () {
      final entity = RegisterCredentialsEntity(
        email: 'example@example.com',
        password: '123456789',
        confirmPassword: '123456789',
      );
      expect(entity.isValidPassword, true);
    });
    test('Should return false if password is invalid', () {
      final entity = RegisterCredentialsEntity(
        email: 'example@example.com',
        password: '1234567',
        confirmPassword: '1234567',
      );
      expect(entity.isValidPassword, false);
    });
    test('Should return true if is password equality', () {
      final entity = RegisterCredentialsEntity(
        email: 'example@example.com',
        password: '12345678',
        confirmPassword: '12345678',
      );
      expect(entity.isPasswordEquality, true);
    });
    test('Should return false if is not password equality', () {
      final entity = RegisterCredentialsEntity(
        email: 'example@example.com',
        password: '12345678',
        confirmPassword: '123456789',
      );
      expect(entity.isPasswordEquality, false);
    });
  });
}
