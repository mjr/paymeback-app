import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

String formatPhoneNumber(String phoneNumber) {
  final sanitizedNumbers = sanitizePhoneNumber(phoneNumber);
  try {
    return UtilBrasilFields.obterTelefone(sanitizedNumbers);
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    try {
      return formatAsPhoneNumber(phoneNumber) ?? "";
    } catch (e) {
      return "";
    }
  }
}

String sanitizePhoneNumber(String phoneNumber) {
  try {
    String onlyNumbers = UtilBrasilFields.removeCaracteres(phoneNumber);
    return onlyNumbers.replaceFirst(RegExp("^[+55]{0,3}"), "");
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return "";
  }
}

double covertMoneyToDouble(String value) {
  try {
    return UtilBrasilFields.converterMoedaParaDouble(value);
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return 0;
  }
}

String convertDoubleToMoney(double value) {
  try {
    String num = value.toStringAsFixed(2).replaceAll('.', ',');
    return 'R\$ $num';
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return 'R\$ 0,00';
  }
}
