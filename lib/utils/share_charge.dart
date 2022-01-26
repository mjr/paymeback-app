import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paymeback/model/charge.dart';
import 'package:share/share.dart';

void shareCharge(BuildContext context, Charge charge) {
  final String messageBeforeEndDate =
      "Olá ${charge.debtor}, o prazo para o pagamento irá vencer dia ${DateFormat('dd/MM').format(charge.endDate)}. Estou no aguardo do pagamento!";

  final String messageSameEndDate =
      "Olá ${charge.debtor}, o prazo para o pagamento vence hoje! Estou no aguardo do pagamento!";

  final String messageAfterEndDate =
      "Olá ${charge.debtor}, o prazo para o pagamento venceu dia ${DateFormat('dd/MM').format(charge.endDate)}. Estou no aguardo do pagamento!";

  String message = charge.endDate.isAfter(DateTime.now())
      ? messageAfterEndDate
      : charge.endDate.isBefore(DateTime.now())
          ? messageBeforeEndDate
          : messageSameEndDate;

  final String subject = "Cobrança - ${charge.title}";

  Share.share(message, subject: subject, sharePositionOrigin: Rect.largest);
}
