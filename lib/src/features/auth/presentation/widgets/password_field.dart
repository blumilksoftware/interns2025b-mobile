import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/custom_text_field.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool isVisible;
  final VoidCallback toggleVisibility;
  final String? Function(String?)? validator;

  const PasswordField({
    super.key,
    required this.controller,
    required this.isVisible,
    required this.toggleVisibility,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: "********",
      obscureText: !isVisible,
      validator: validator,
      suffixIcon: IconButton(
        icon: Icon(
          isVisible ? Icons.visibility_off : Icons.visibility,
          color: Colors.black54,
        ),
        onPressed: toggleVisibility,
      ),
    );
  }
}
