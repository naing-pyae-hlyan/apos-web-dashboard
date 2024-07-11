import 'package:intl/intl.dart';

extension CurrencyExt on dynamic {
  String toCurrencyFormat({
    String? countryIso,
    bool needPlusSign = false,
    bool useDecimal = true,
  }) {
    if (this == null) return '';
    final balance = toString().replaceAll(',', '');
    if (balance.isEmpty) return '';

    final format = useDecimal
        ? NumberFormat('#,##0.00', 'en_US')
        : NumberFormat('#,##0', 'en_US');

    String prefix = '';
    String postfix = '';
    if (balance.contains('-')) {
      prefix = '(';
      postfix = ')';
    }
    if (needPlusSign && !balance.contains('-')) {
      prefix = '';
    }

    if (double.tryParse(balance.toString()) == null) {
      return (this is String) ? this : '';
    }

    return prefix +
        (countryIso ?? '') +
        format.format(double.parse(balance.replaceAll('-', ''))) +
        postfix;
  }

  bool isPostive() {
    if (this == null) return true;
    final balance = toString().replaceAll(',', '');

    if (balance.isEmpty || !balance.contains('-')) {
      return true;
    } else {
      return false;
    }
  }
}

extension StringExt on String {
  // Color get getCurrencyColor =>
  //     contains('-') || startsWith('(') ? currencyRed : currencyGreen;

  // Color getCurrencyColor2({
  //   bool darker = false,
  // }) =>
  //     contains('-') || startsWith('(')
  //         ? currencyRed
  //         : darker
  //             ? currencyGreenDark
  //             : currencyGreen;

  String toPhoneNumberFormat({String? dialCode}) {
    if (isEmpty) return '';
    String data = replaceAll(' ', '').replaceAll('-', '');
    if (dialCode != null) {
      data = data.replaceAll(dialCode, '');
    }
    if (data.length > 4) {
      data = '${data.substring(0, 3)} ${data.substring(3, data.length)}';
    }
    if (data.length > 7) {
      data = data.replaceAll(' ', '');
      data =
          '${data.substring(0, 3)} ${data.substring(3, 6)} ${data.substring(6, data.length)}';
    }
    return data;
  }
}
