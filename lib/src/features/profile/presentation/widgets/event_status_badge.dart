import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_status.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';

class EventStatusBadge extends StatelessWidget {
  final EventStatus status;

  const EventStatusBadge({super.key, required this.status});

  Color get _backgroundColor {
    switch (status) {
      case EventStatus.draft:
        return AppColors.draftEventBadge.withValues(alpha: 0.5);
      case EventStatus.published:
        return AppColors.blueLabelBackground.withValues(alpha: 0.2);
      case EventStatus.ongoing:
        return AppColors.primary.withValues(alpha: 0.2);
      case EventStatus.canceled:
      case EventStatus.ended:
        return AppColors.grey.withValues(alpha: 0.2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _backgroundColor;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.label(context),
        style: TextStyle(
          color: AppColors.black,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
