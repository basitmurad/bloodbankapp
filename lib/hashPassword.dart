import 'package:crypto/crypto.dart';
import 'dart:convert'; // For utf8.encode

String hashPassword(String password) {
  return sha256.convert(utf8.encode(password)).toString();
}
