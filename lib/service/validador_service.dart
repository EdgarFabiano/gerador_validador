

import 'package:gerador_validador/service/util.dart';

class ValidadorService {

  static validateCpf(String strCPF) {
    strCPF = strCPF.replaceAll(new RegExp(r'[^\d]+'), '');
    if (strCPF.length != 11) {
      return false;
    }
    var restos = Util.createCpf(strCPF);
    if (restos[0] != int.tryParse(strCPF.substring(9, 10), radix: 10)) {
      return false;
    }
    if (restos[1] != int.tryParse(strCPF.substring(10, 11), radix: 10)) {
      return false;
    }
    return true;
  }

}