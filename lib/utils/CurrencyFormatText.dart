import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat("#,##0", "en_US");

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String value = newValue.text.replaceAll(',', '').replaceAll('.', '');

    if (value.isEmpty) return newValue;

    double parsedValue = double.tryParse(value) ?? 0;

    String newText = _formatter.format(parsedValue);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
