import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/core/routes/app_routes.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_by_id_provider.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_controller_provider.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_author_tile.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_image.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_info_tile.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_localization_map.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/providers/profile_controller_provider.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_status.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/labeled_text.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/button.dart';
import 'package:intl/intl.dart';

class EventDetailsBody extends ConsumerWidget {
  const EventDetailsBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final controllerNotifier = ref.read(eventsControllerProvider);

    final event = ref.watch(eventsControllerProvider).selectedEvent;
    if (event == null) return const SizedBox();

    final isParticipating = event.isParticipating;
    final buttonText = isParticipating
        ? localizations.leave
        : localizations.join;

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
                if (event.participantCount > 0)
                  EventInfoTile(
                    icon: Icons.people_outline,
                    title:
                        '${event.participantCount} ${event.participantCount == 1 ? localizations.participant : localizations.participants}',
                  ),
                if (event.start != null)
                  EventInfoTile(
                    icon: Icons.calendar_today_outlined,
                    title: DateFormat(
                      'd MMMM yyyy',
                      locale,
                    ).format(event.start!),
                    subtitle: DateFormat('EEEE, HH:mm', locale)
                        .format(event.start!)
                        .replaceFirstMapped(
                          RegExp(r'^\w'),
                          (m) => m.group(0)!.toUpperCase(),
                        ),
                  ),
                if (event.address != null)
                  EventInfoTile(
                    icon: Icons.location_on_outlined,
                    title: event.address!,
                  ),
                if (event.owner != null) EventAuthorTile(owner: event.owner!),

                const SizedBox(height: 16),

                Consumer(
                  builder: (context, ref, _) {
                    final profileUser = ref.watch(profileControllerProvider).user;
                    final canEdit = profileUser != null &&
                        event.ownerId == profileUser.id &&
                        (event.status == EventStatus.draft || event.status == EventStatus.published);

                    if (!canEdit) return const SizedBox.shrink();

                    return Column(
                      children: [
                        Button(
                          label: localizations.edit,
                          icon: Icons.edit_outlined,
                          fullWidth: true,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.eventEdit,
                                arguments: event.id,
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                ),

                Button(
                  label: buttonText,
                  icon: isParticipating
                      ? Icons.remove_circle_outline
                      : Icons.add_circle_outline,
                  fullWidth: true,
                  onPressed: () async {
                    await controllerNotifier.toggleParticipation(event.id);
                    ref.invalidate(eventByIdProvider(event.id));
                  },
                ),

                const SizedBox(height: 24),

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

                const SizedBox(height: 16),
                EventLocationMap(event: event),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
