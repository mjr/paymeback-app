class Charge {
  final String id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final double value;
  final String debtor;
  final String phoneNumber;
  final String? description;
  final bool paid;

  Charge(
      {required this.id,
      required this.title,
      required this.startDate,
      required this.endDate,
      required this.value,
      required this.debtor,
      required this.phoneNumber,
      required this.paid,
      this.description});

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
