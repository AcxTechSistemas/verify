import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart';

abstract class DataCrypto {
  String generateKey({required String userId});
  String encrypt({
    required String plainText,
    required String key,
  });
  String decrypt({
    required String cipherText,
    required String key,
  });
}

class DataCryptoImpl implements DataCrypto {
  @override
  String generateKey({required String userId}) {
    const keySuffix = 'Epy4YfsVW5';
    const keyPrefix = 'LXyVVN13fQ';
    final keyInput = keySuffix + userId + keyPrefix;
    final keyBytes = utf8.encode(keyInput);

    Digest digest = sha256.convert(keyBytes);
    String key = digest.toString();

    if (key.length < 32) {
      key = key.padRight(32, '\x00');
    } else if (key.length > 32) {
      key = key.substring(0, 32);
    }
    return key;
  }

  @override
  String encrypt({
    required String plainText,
    required String key,
  }) {
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(
      AES(Key.fromUtf8(key), mode: AESMode.ecb),
    );

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    final encryptedMessage = encrypted.base64;
    final encryptedIv = base64.encode(iv.bytes);
    return '$encryptedMessage|$encryptedIv';
  }

  @override
  String decrypt({
    required String cipherText,
    required String key,
  }) {
    final parts = cipherText.split('|');
    final encryptedMessage = Encrypted.fromBase64(parts[0]);
    final encryptedIv = base64.decode(parts[1]);

    final encrypter = Encrypter(
      AES(Key.fromUtf8(key), mode: AESMode.ecb),
    );

    return encrypter.decrypt(encryptedMessage, iv: IV(encryptedIv));
  }
}
