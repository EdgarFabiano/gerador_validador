import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

String dateFormat(String date) {
  return formatDate(DateTime.parse(date), [dd, '/', mm, '/', yyyy]).toString();
}

String formatNumber(dynamic valor) {
  return NumberFormat.decimalPattern('pt_BR').format(valor);
}

String formatCurrency(dynamic valor) {
  return 'R\$ ' + NumberFormat.compactLong(locale: 'pt_BR').format(valor);
}

