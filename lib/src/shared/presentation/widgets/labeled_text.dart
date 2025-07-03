import 'package:flutter/material.dart';

class LabeledText extends StatelessWidget {
  final String label;
  const LabeledText(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Color(0xFF6C7278),
      ),
    );
  }
}
