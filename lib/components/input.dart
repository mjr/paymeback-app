import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class Input extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? initalValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String value) onChanged;

  const Input({
    Key? key,
    required this.label,
    required this.icon,
    required this.onChanged,
    this.initalValue,
    this.validator,
    this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            initialValue: initalValue,
            validator: validator,
            onChanged: onChanged,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color(0xFFB1B0B8),
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              labelText: label,
              labelStyle: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xFFB1B0B8),
              ),
              icon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Icon(icon, color: Color(0xFF5DB075)),
                  ),
                  Container(
                    width: 1,
                    height: 48,
                    color: Color(0xFFE3E3E6),
                  )
                ],
              ),
              border: InputBorder.none
            ),
          ),
          Divider(height: 1, thickness: 1, color: Color(0xFFE3E3E6))
        ],
      ),
    );
  }
}