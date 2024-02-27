
import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/pointycastle.dart';

class EncryptData {
  static String encryptAES(String text, String password) {
    final keyBytes = Uint8List.fromList(utf8.encode(password));
    final iv = Uint8List(16);
    final cipher = BlockCipher("AES/CBC")..init(true, ParametersWithIV(KeyParameter(keyBytes), iv));

    final inputBytes = Uint8List.fromList(utf8.encode(text));
    final encryptedBytes = encryptBytes(cipher, inputBytes);

    final encryptedText = base64.encode(encryptedBytes);

    final urlEnc = Uri.encodeComponent(encryptedText);

    return urlEnc;
  }

  static String decryptAES(String encryptedText, String password) {
    final keyBytes = Uint8List.fromList(utf8.encode(password));
    final iv = Uint8List(16);
    final cipher = BlockCipher("AES/CBC")..init(false, ParametersWithIV(KeyParameter(keyBytes), iv));

    final urlDec = Uri.decodeComponent(encryptedText);
    final encryptedBytes = base64.decode(urlDec);
    final decryptedBytes = decryptBytes(cipher, encryptedBytes);

    final decryptedText = utf8.decode(decryptedBytes);

    return decryptedText;
  }

  static Uint8List encryptBytes(BlockCipher cipher, Uint8List input) {
    final blockSize = cipher.blockSize;
    final paddedInput = padBlock(input, blockSize);
    final result = Uint8List(paddedInput.length);
    for (var i = 0; i < paddedInput.length; i += blockSize) {
      cipher.processBlock(paddedInput, i, result, i);
    }
    return result;
  }

  static Uint8List decryptBytes(BlockCipher cipher, Uint8List input) {
    final blockSize = cipher.blockSize;
    final result = Uint8List(input.length);
    for (var i = 0; i < input.length; i += blockSize) {
      cipher.processBlock(input, i, result, i);
    }
    return removePadding(result);
  }

  static Uint8List padBlock(Uint8List input, int blockSize) {
    final padLength = blockSize - (input.length % blockSize);
    final padded = Uint8List(input.length + padLength);
    padded.setAll(0, input);
    for (var i = input.length; i < padded.length; i++) {
      padded[i] = padLength;
    }
    return padded;
  }

  static Uint8List removePadding(Uint8List input) {
    final padLength = input.last;
    return input.sublist(0, input.length - padLength);
  }
}