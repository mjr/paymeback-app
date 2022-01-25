import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChargeCard extends StatelessWidget {
  final String title;
  final String endDate;
  final double value;
  final String debtorName;

  const ChargeCard(
      {Key? key,
      required this.title,
      required this.endDate,
      required this.value,
      required this.debtorName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        borderOnForeground: true,
        child: InkWell(
          splashColor: Colors.green.withAlpha(30),
          onTap: () {
            if (kDebugMode) {
              print('Card tapped');
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                  title: SizedBox(
                width: 20,
                child: Row(
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      strutStyle: const StrutStyle(fontSize: 12.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: Text(
                        "R\$ $value",
                        style: GoogleFonts.inter(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              ListBody(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 14),
                    child: Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.event,
                              size: 20,
                              color: Color(0xFFB1B0B8),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              endDate,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFFB1B0B8),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.account_circle,
                              size: 20,
                              color: Color(0xFFB1B0B8),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              debtorName,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFFB1B0B8),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
