import 'package:paymeback/utils/masks.dart';

class ChargeFilters {
  late String? debtor;
  late String? phoneNumber;
  late String? fromEndDate;
  late String? untilEndDate;
  late String? fromValue;
  late String? untilValue;

  ChargeFilters() {
    debtor = "";
    phoneNumber = "";
    fromEndDate = "";
    untilEndDate = "";
    fromValue = "";
    untilValue = "";
  }

  void reset() {
    debtor = "";
    phoneNumber = "";
    fromEndDate = "";
    untilEndDate = "";
    fromValue = "";
    untilValue = "";
  }

  String formatForURLQuery() {
    late Map<String, dynamic> query = {};

    if (debtor != null && debtor!.isNotEmpty) {
      query["debtor_name_contains"] = debtor;
    }

    if (phoneNumber != null && phoneNumber!.isNotEmpty) {
      query["debtor_phone"] = phoneNumber;
    }

    if (fromValue != null && untilValue != null) {
      double? dbFromValue = covertMoneyToDouble(fromValue!);
      double? dbUntilValue = covertMoneyToDouble(untilValue!);

      if (!(dbFromValue == 0 && dbUntilValue == 0)) {
        query["value__range"] = "$dbFromValue,$dbUntilValue";
      }
    }

    if (fromEndDate != null &&
        untilEndDate != null &&
        fromEndDate!.isNotEmpty &&
        untilEndDate!.isNotEmpty) {
      query["date_to_receive__range"] = "$fromEndDate,$untilEndDate";
    }

    if (query.isEmpty) {
      return "";
    }

    return '?${Uri(queryParameters: query).query}';
  }
}
