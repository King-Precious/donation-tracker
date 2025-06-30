import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.labeltext,
    this.icon,
  }
  );

  final String labeltext;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
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
      ),
    );
  }
}
