import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IconWithText extends StatelessWidget {
  final Icon icon;
  final String text;

  const IconWithText({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFFB1B0B8),
          ),
        ),
      ],
    );
  }
}
