import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Input extends StatelessWidget {
  final void Function(String value) onChanged;
  final String? label;
  final bool? externalLabel;
  final bool? showLabel;
  final String? hintText;
  final IconData? icon;
  final String? initalValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLines;
  final EdgeInsetsGeometry? padding;

  const Input(
      {Key? key,
      required this.onChanged,
      this.label = "",
      this.icon,
      this.keyboardType,
      this.initalValue,
      this.validator,
      this.controller,
      this.hintText,
      this.maxLines,
      this.externalLabel = true,
      this.showLabel = true,
      this.padding = const EdgeInsets.all(8.0)})
      : super(key: key);

  Widget getLabel() {
    var label = this.label ?? '';
    return externalLabel == true && showLabel == true && label.isNotEmpty
        ? Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          )
        : const SizedBox.shrink();
  }

  String? getHintText() {
    return externalLabel == false && showLabel == true ? label : hintText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 80,
          maxHeight: 100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getLabel(),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: TextFormField(
                controller: controller,
                initialValue: initalValue,
                validator: validator,
                onChanged: onChanged,
                keyboardType: keyboardType,
                maxLines: maxLines,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFB1B0B8),
                ),
                decoration: InputDecoration(
                    hintText: getHintText(),
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
            ),
          ],
        ),
      ),
    );
  }
}
