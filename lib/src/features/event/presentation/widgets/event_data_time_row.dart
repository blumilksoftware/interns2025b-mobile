import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';
import 'package:intl/intl.dart';

class EventDateTimeRow extends StatelessWidget {
  final DateTime? date;

  const EventDateTimeRow({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    if (date == null) return const SizedBox.shrink();

    final locale = Localizations.localeOf(context).toLanguageTag();
    final dateText = DateFormat('d MMMM yyyy – HH:mm', locale).format(date!);

    return Row(
      children: [
        const Icon(
          Icons.calendar_today_outlined,
          size: 20,
          color: AppColors.grey,
        ),
        const SizedBox(width: 8),
        Text(
          dateText,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
        ),
      ],
    );
  }
}
