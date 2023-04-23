import 'package:flutter_test/flutter_test.dart';
import 'package:verify/app/modules/database/utils/data_crypto.dart';

void main() {
  late DataCrypto dataCrypto;

  setUp(() {
    dataCrypto = DataCryptoImpl();
  });
  test('Should return 32Bytes generated Key', () {
    final key = dataCrypto.generateKey(userId: 'l0SZMNQYjnXngjFOxaLH');
    final is32BytesKey = key.codeUnits.length == 32;
    expect(is32BytesKey, true);
  });

  test('Should return String encrypted', () {
    const plainText = 'teste';
    final key = dataCrypto.generateKey(userId: 'l0SZMNQYjnXngjFOxaLH');
    final encrypted = dataCrypto.encrypt(plainText: plainText, key: key);
    final isencrypted = encrypted.codeUnits.length == 49;
    expect(isencrypted, true);
  });

  test('Should return String decrypted', () {
    const plainText = 'teste';
    final key = dataCrypto.generateKey(userId: 'l0SZMNQYjnXngjFOxaLH');
    final cipherText = dataCrypto.encrypt(plainText: plainText, key: key);
    final isencrypted = cipherText.codeUnits.length == 49;
    expect(isencrypted, true);
    final decrypted = dataCrypto.decrypt(cipherText: cipherText, key: key);
    expect(decrypted, equals('teste'));
  });
}
