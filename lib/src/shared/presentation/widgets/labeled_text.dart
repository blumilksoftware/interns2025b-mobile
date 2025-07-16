import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';

class LabeledText extends StatelessWidget {
  final String label;
  final double? fontSize;
  final bool isBold;
  final Color? color;

  const LabeledText(
    this.label, {
    super.key,
    this.fontSize,
    this.isBold = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
        fontSize: fontSize ?? 14,
        color: color ?? AppColors.textDisabled,
      ),
    );
  }
}
