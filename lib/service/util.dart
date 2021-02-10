
class Util {
  static modulo11(String string, int size, int mod) {
    var soma = 0;
    for (var i = 1; i <= size; i++) {
      soma = soma + int.parse(string.substring(i - 1, i)) * (mod - i);
    }
    var resto = (soma * 10) % 11;
    if ((resto == 10) || (resto == 11)) {
      resto = 0;
    }
    return resto;
  }

  static createCpf(String strCPF) {
    strCPF = strCPF.replaceAll(new RegExp(r'[^\d]+'), '');
    if (strCPF == '00000000000' ||
        strCPF == '11111111111' ||
        strCPF == '22222222222' ||
        strCPF == '33333333333' ||
        strCPF == '44444444444' ||
        strCPF == '55555555555' ||
        strCPF == '66666666666' ||
        strCPF == '77777777777' ||
        strCPF == '88888888888' ||
        strCPF == '99999999999') {
      return false;
    }
    var restos = [modulo11(strCPF, 9, 11), modulo11(strCPF, 10, 12)];
    return restos;
  }
}