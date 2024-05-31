import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';

class EncryptionHelper {
  static final _key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1');
  static final _iv = encrypt.IV.fromLength(16);
  static final _encrypter = encrypt.Encrypter(encrypt.AES(_key));

  static String encryptText(String text) {
    final encrypted = _encrypter.encrypt(text, iv: _iv);
    return encrypted.base64;
  }

  static String decryptText(String text) {
    final decrypted = _encrypter.decrypt64(text, iv: _iv);
    return decrypted;
  }
}
