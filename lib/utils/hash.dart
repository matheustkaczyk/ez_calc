import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';

String md5RandomString() {
  final randomNumber = Random().nextDouble();
  final randomBytes = utf8.encode(randomNumber.toString());
  final randomString = md5.convert(randomBytes).toString();
  return randomString;
}