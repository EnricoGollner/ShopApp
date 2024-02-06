import 'dart:io';

import 'package:flutter/services.dart';
import 'dart:math' as math;

///Classe para formatar os campos numéricos
class DecimalTextInputFormatter extends TextInputFormatter {
  ///`decimalRange` - Quantidade de zeros depois do sinal
  DecimalTextInputFormatter({this.decimalRange = 2});

  final int decimalRange;

  ///Retorna o sinal decimal, de acordo com a localização do dispositivo
  static FilteringTextInputFormatter get signal =>
      Platform.localeName == 'pt_BR'
          ? FilteringTextInputFormatter.allow(RegExp("[0-9,]"))
          : FilteringTextInputFormatter.allow(RegExp("[0-9.]"));

  ///Nega sinais decimais no campo, usado quando for desejado o uso de numeros inteiros
  static FilteringTextInputFormatter notAllowSignal() => FilteringTextInputFormatter.deny(RegExp("[,.]"));

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;
    String signal = Platform.localeName == 'pt_BR' ? ',' : '.';

    String value = newValue.text;

    if (value.contains(signal) &&
        value.substring(value.indexOf(signal) + 1).length > decimalRange) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    } else if (value == signal) {
      truncated = "0$signal";

      newSelection = newValue.selection.copyWith(
        baseOffset: math.min(truncated.length, truncated.length + 1),
        extentOffset: math.min(truncated.length, truncated.length + 1),
      );
    } else if (value.contains(signal)) {
      String tempValue = value.substring(value.indexOf(signal) + 1);
      if (tempValue.contains(signal)) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      }
      if (value.indexOf(signal) == 0) {
        truncated = "0$truncated";
        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }
    }
    if (value.contains(" ") || value.contains("-")) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    }

    return TextEditingValue(
      text: truncated,
      selection: newSelection,
      composing: TextRange.empty,
    );
  }
}
