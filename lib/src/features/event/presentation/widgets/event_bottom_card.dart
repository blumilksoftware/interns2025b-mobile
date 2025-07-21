import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_image.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_price_tag.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_model.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';
import 'package:intl/intl.dart';

class EventBottomCard extends StatelessWidget {
  final Event event;
  final VoidCallback onClose;

  const EventBottomCard({
    super.key,
    required this.event,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toLanguageTag();

    final dateText = event.start != null
        ? DateFormat('d MMMM yyyy – HH:mm', locale).format(event.start!)
        : '';

    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(12),
      color: AppColors.backgroundLight,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EventImage(
              imageUrl: event.imageUrl,
              width: 80,
              height: 80,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          event.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: onClose,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),
                  if (event.start != null)
                    Text(
                      dateText,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.shadeGrey700,
                      ),
                    ),
                  if (event.location != null)
                    Text(
                      event.location!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  if (event.ageCategory != null)
                    Text(
                      event.ageCategory!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.shadeGrey700,
                      ),
                    ),
                  const SizedBox(height: 6),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      EventPriceTag(
                        isPaid: event.isPaid,
                        paidText: localizations.paid,
                        freeText: localizations.free,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(localizations.seeDetails),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
