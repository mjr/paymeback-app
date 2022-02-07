import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/foundation.dart';

String formatPhoneNumber(String phoneNumber) {
  final sanitizedNumbers = sanitizePhoneNumber(phoneNumber);
  try {
    return UtilBrasilFields.obterTelefone(sanitizedNumbers);
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return "";
  }
}

String sanitizePhoneNumber(String phoneNumber) {
  try {
    return UtilBrasilFields.removeCaracteres(phoneNumber);
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return "";
  }
}

double? covertMoneyToDouble(String value) {
  try {
    return UtilBrasilFields.converterMoedaParaDouble(value);
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return 0;
  }
}
