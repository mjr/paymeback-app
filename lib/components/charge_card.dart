import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';
import 'package:paymeback/components/icon_with_text.dart';
import 'package:paymeback/model/charge.dart';
import 'package:paymeback/screens/detail_charge.dart';
import 'package:paymeback/utils/share_charge.dart';

class ChargeCard extends StatelessWidget {
  final Charge charge;

  const ChargeCard({Key? key, required this.charge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: const BorderSide(color: Color(0xbbbdbdbd), width: 1)),
        child: InkWell(
          splashColor: Colors.green.withAlpha(30),
          customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: const BorderSide(color: Color(0xbbbdbdbd), width: 1)),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailChargeScreen(charge: charge)));
          },
          onLongPress: () {
            shareCharge(context, charge);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      charge.title,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      strutStyle: const StrutStyle(fontSize: 12.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 26,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        // mainAxisAlignment: ,
                        children: [
                          Text("R\$",
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              )),
                          Text(
                            NumberFormat.currency(locale: 'pt_BR', symbol: '')
                                .format(charge.value)
                                .toString(),
                            style: GoogleFonts.inter(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ListBody(
                children: <Widget>[
                  Row(
                    children: [
                      IconWithText(
                          icon: const Icon(
                            Icons.calendar_today,
                            size: 14,
                            color: Color(0xFFB1B0B8),
                          ),
                          text: DateFormat('dd/MM/yyyy')
                              .format(charge.endDate)
                              .toString()),
                      const SizedBox(width: 12),
                      IconWithText(
                          icon: const Icon(
                            Icons.account_circle,
                            size: 14,
                            color: Color(0xFFB1B0B8),
                          ),
                          text: charge.debtor),
                    ],
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}
