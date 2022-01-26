import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paymeback/components/input.dart';

class InputRange extends StatelessWidget {
  final String label;
  final String? hintText;
  final Icon? icon;
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
  final List<TextInputFormatter>? inputFormatters;

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
      this.maxLines,
      this.inputFormatters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child:
                Text(label, style: const TextStyle(color: Color(0xFF666666))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Input(
                  hintText: hintText,
                  showLabel: false,
                  onChanged: onChanged1,
                  icon: icon,
                  controller: controller1,
                  validator: validator1,
                  keyboardType: keyboardType,
                  initalValue: initalValue1,
                  maxLines: maxLines,
                  inputFormatters: inputFormatters,
                ),
              ),
              const SizedBox(width: 4),
              const Text("até"),
              const SizedBox(width: 4),
              Expanded(
                child: Input(
                  hintText: hintText,
                  showLabel: false,
                  onChanged: onChanged2,
                  icon: icon,
                  controller: controller2,
                  validator: validator2,
                  keyboardType: keyboardType,
                  initalValue: initalValue2,
                  maxLines: maxLines,
                  inputFormatters: inputFormatters,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
