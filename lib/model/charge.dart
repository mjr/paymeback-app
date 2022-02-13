import 'package:paymeback/utils/masks.dart';

class Charge {
  late String? id;
  late String title;
  late DateTime startDate;
  late DateTime endDate;
  late double value;
  late String debtor;
  late String phoneNumber;
  late String? description;
  late bool paid;

  Charge(
      {this.id,
      required this.title,
      required this.startDate,
      required this.endDate,
      required this.value,
      required this.debtor,
      required this.phoneNumber,
      required this.paid,
      this.description});

  Map<String, dynamic> toMap() {
    return {
      'pk': id,
      'title': title,
      'debtorName': debtor,
      'loanDate': startDate.toString(),
      'dateToReceive': endDate.toString(),
      'value': value,
      'debtorPhone': phoneNumber,
      'details': description,
    };
  }

  factory Charge.fromForm(Map<String, dynamic> form) {
    return Charge(
      id: form['id'],
      title: form['title'],
      debtor: form['debtor'],
      startDate: DateTime.parse(form['startDate']),
      endDate: DateTime.parse(form['endDate']),
      value: covertMoneyToDouble(form['value']),
      phoneNumber: form['phoneNumber'],
      description: form['description'],
      paid: form['paid'] == "true",
    );
  }

  factory Charge.fromJson(Map<String, dynamic> json) {
    return Charge(
      id: json['pk'],
      title: json['title'],
      debtor: json['debtorName'],
      startDate: DateTime.parse(json['loanDate']),
      endDate: DateTime.parse(json['dateToReceive']),
      value: double.parse(json['value']),
      phoneNumber: json['debtorPhone'],
      description: json['details'],
      paid: json['paid'],
    );
  }
}
