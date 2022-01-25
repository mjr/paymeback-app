import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Input extends StatelessWidget {
  final String label;
  final IconData? icon;
  final String? initalValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function(String value) onChanged;
  final int? maxLines;

  const Input(
      {Key? key,
      required this.label,
      required this.onChanged,
      this.icon,
      this.maxLines,
      this.keyboardType,
      this.initalValue,
      this.validator,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            initialValue: initalValue,
            validator: validator,
            onChanged: onChanged,
            maxLines: maxLines,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: const Color(0xFFB1B0B8),
            ),
            keyboardType: keyboardType,
            decoration: InputDecoration(
                filled: true,
                labelText: label,
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Icon(icon, color: const Color(0xFF5DB075)),
                    ),
                    Container(
                      width: 1,
                      height: 48,
                      color: const Color(0xFFE3E3E6),
                    )
                  ],
                ),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xE8E8E8E8))),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                )),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFE3E3E6))
        ],
      ),
    );
  }
}
