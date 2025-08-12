import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.labeltext,
    required this.controller,
    this.validator,
    this.icon,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String labeltext;
  final Widget? icon;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: icon,
        labelText: labeltext,
        labelStyle: const TextStyle(color: Themes.borderColor),
        focusedBorder: const OutlineInputBorder(
            // borderSide: BorderSide(color: Colors.green[900]!),
            ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Themes.borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(10)),
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 12,
          height: 1.2,
        ),
        contentPadding: const EdgeInsets.all(16.0),
      ),
    );
  }
}
