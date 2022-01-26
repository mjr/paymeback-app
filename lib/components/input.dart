import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  final void Function(String value) onChanged;
  final String? label;
  final bool? externalLabel;
  final bool? showLabel;
  final String? hintText;
  final Icon? icon;
  final String? initalValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLines;
  final EdgeInsetsGeometry? padding;
  final List<TextInputFormatter>? inputFormatters;

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
      this.padding = const EdgeInsets.all(0),
      this.inputFormatters})
      : super(key: key);

  Widget getLabel() {
    var label = this.label ?? '';
    return externalLabel == true && showLabel == true && label.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child:
                Text(label, style: const TextStyle(color: Color(0xFF666666))),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                autofocus: true,
                onChanged: onChanged,
                controller: controller,
                initialValue: initalValue,
                validator: validator,
                keyboardType: keyboardType,
                maxLines: maxLines,
                inputFormatters: inputFormatters,
                decoration: InputDecoration(
                  suffixIcon: icon,
                  hintText: getHintText(),
                  hintStyle: const TextStyle(color: Color(0xFFBDBDBD)),
                  contentPadding: const EdgeInsets.all(16),
                  filled: true,
                  fillColor: const Color(0xFFF6F6F6),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(
                      color: Color(0xFFE8E8E8),
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(
                      color: Color(0xFF5DB075),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
