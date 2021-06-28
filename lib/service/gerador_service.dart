import 'dart:math';

import 'package:gerador_validador/service/util.dart';

class GeradorService {
  static String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789';
  static String _numbers = '0123456789';
  static Random _rnd = Random();

  static String _getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  static String _getRandomNumber(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _numbers.codeUnitAt(_rnd.nextInt(_numbers.length))));

  static String generateCpf() {
    String strCPF = _getRandomNumber(9);
    String resto1 = Util.modulo11(strCPF, 9, 11).toString();
    String resto2 = Util.modulo11(strCPF + resto1, 10, 12).toString();
    strCPF = strCPF + resto1.toString() + resto2.toString();

    return strCPF;
  }

}
