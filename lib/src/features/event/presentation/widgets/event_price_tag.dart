import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';

class EventPriceTag extends StatelessWidget {
  final bool isPaid;
  final String paidText;
  final String freeText;

  const EventPriceTag({
    super.key,
    required this.isPaid,
    required this.paidText,
    required this.freeText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: isPaid ? const Color(0x330A84FF) : Colors.green.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        isPaid ? paidText : freeText,
        style: TextStyle(
          color: isPaid ? const Color(0xFF0A84FF) : AppColors.text,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
