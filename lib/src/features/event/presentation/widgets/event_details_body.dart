import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_author_tile.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_image.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_info_tile.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_localization_map.dart';
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
    final locale = Localizations.localeOf(context).toLanguageTag();

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: EventImage(imageUrl: event.imageUrl, height: 250),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: AppColors.black,
                  ),
                ),

                const SizedBox(height: 12),
                if (event.start != null)
                  EventInfoTile(
                    icon: Icons.calendar_today_outlined,
                    title: DateFormat('d MMMM yyyy', locale).format(event.start!),
                    subtitle: DateFormat('EEEE, HH:mm', locale)
                        .format(event.start!)
                        .replaceFirstMapped(RegExp(r'^\w'), (m) => m.group(0)!.toUpperCase()),
                  ),

                if (event.address != null)
                  EventInfoTile(
                    icon: Icons.location_on_outlined,
                    title: event.address!,
                  ),

                if (event.owner != null)
                  EventAuthorTile(owner: event.owner),

                EventLocationMap(event: event),
                const SizedBox(height: 16),

                LabeledText(
                  localizations.information,
                  fontSize: 20,
                  isBold: true,
                ),
                const SizedBox(height: 8),
                if (event.description != null && event.description!.isNotEmpty)
                  Text(
                    event.description!,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: AppColors.black),
                  ),
                if (event.description == null || event.description!.isEmpty)
                  Text(localizations.noInformation),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
