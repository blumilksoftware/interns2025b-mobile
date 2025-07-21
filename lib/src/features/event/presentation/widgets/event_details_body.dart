import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_data_time_row.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_image.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_price_tag.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_model.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/labeled_text.dart';
import 'package:intl/intl.dart';

class EventDetailsBody extends StatelessWidget {
  final Event event;

  const EventDetailsBody({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: EventImage(
              imageUrl: event.imageUrl,
              height: 250,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                  style: TextStyle(
                fontWeight: FontWeight.bold ,
                  fontSize: 32,
                  color: AppColors.black,
                ),
                ),
                EventDateTimeRow(date: event.start),
                Row(
                  children: [
                    if (event.address != null)
                      const Icon(Icons.location_on_outlined, size: 20, color: AppColors.grey),
                      const SizedBox(width: 8),
                      Text(
                        event.address!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                      ),
                  ],
                ),

                const SizedBox(height: 12),
                
                const SizedBox(height: 8),
                if (event.ageCategory != null)
                  Text(
                    "${event.ageCategory!}",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.shadeGrey700),
                  ),
                const SizedBox(height: 8),
                const SizedBox(height: 16),
                LabeledText("Informacje dodatkowe", fontSize: 18),
                const SizedBox(height: 8),
                if (event.description != null && event.description!.isNotEmpty)
                  Text(event.description!),
                if (event.description == null || event.description!.isEmpty)
                  const Text("Brak opisu wydarzenia."),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
