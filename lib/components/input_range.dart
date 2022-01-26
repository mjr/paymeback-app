import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paymeback/components/input.dart';

class InputRange extends StatelessWidget {
  final String label;
  final String? hintText;
  final IconData? icon;
  final String? initalValue1;
  final String? initalValue2;
  final String? Function(String?)? validator1;
  final String? Function(String?)? validator2;
  final TextEditingController? controller1;
  final TextEditingController? controller2;
  final TextInputType? keyboardType;
  final void Function(String value) onChanged1;
  final void Function(String value) onChanged2;
  final int? maxLines;

  const InputRange(
      {Key? key,
      required this.label,
      required this.onChanged1,
      required this.onChanged2,
      this.icon,
      this.keyboardType,
      this.initalValue1,
      this.initalValue2,
      this.validator1,
      this.validator2,
      this.controller1,
      this.controller2,
      this.hintText,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Input(
                  hintText: hintText,
                  showLabel: false,
                  onChanged: (value) {},
                  icon: icon,
                  controller: controller1,
                  validator: validator1,
                  keyboardType: keyboardType,
                  initalValue: initalValue1,
                  maxLines: maxLines,
                  padding: const EdgeInsets.all(0),
                ),
              ),
              const SizedBox(width: 4),
              const Text("até"),
              const SizedBox(width: 4),
              Expanded(
                child: Input(
                  hintText: hintText,
                  showLabel: false,
                  onChanged: (value) {},
                  icon: icon,
                  controller: controller2,
                  validator: validator2,
                  keyboardType: keyboardType,
                  initalValue: initalValue2,
                  maxLines: maxLines,
                  padding: const EdgeInsets.all(0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
