import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_data_time_row.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_image.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_price_tag.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_model.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event,});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EventImage(imageUrl: event.imageUrl),

          Container(
            color: AppColors.backgroundLight,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    EventDateTimeRow(date: event.start),
                    EventPriceTag(
                      isPaid: event.isPaid,
                      paidText: localizations.paid,
                      freeText: localizations.free,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  event.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                if (event.location != null)
                  Text(
                    event.location!,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: AppColors.black),
                  ),

                if (event.ageCategory != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      event.ageCategory!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.shadeGrey700,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
