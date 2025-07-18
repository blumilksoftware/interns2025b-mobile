import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_controller_provider.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_scroll_controller_provider.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_card.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_list_loader.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/labeled_text.dart';

class EventsList extends ConsumerWidget {
  const EventsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(eventsControllerProvider);
    final notifier = ref.read(eventsControllerProvider.notifier);
    final scrollController = ref.watch(eventScrollControllerProvider);
    final localizations = AppLocalizations.of(context)!;

    if (controller.isLoading && controller.events.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.errorMessage != null && controller.events.isEmpty) {
      return Center(child: Text(controller.errorMessage!));
    }

    final eventsToShow = controller.filteredEvents;

    return RefreshIndicator(
      onRefresh: () => notifier.loadEvents(refresh: true),
      child: ListView.builder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: eventsToShow.isEmpty ? 2 : eventsToShow.length + (controller.hasMore ? 2 : 1),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: LabeledText(
                localizations.searchEvents,
                isBold: true,
                fontSize: 22,
              ),
            );
          }
          if (eventsToShow.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                localizations.noEventsFound,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }
          final adjustedIndex = index - 1;
          if (adjustedIndex < eventsToShow.length) {
            return EventCard(event: eventsToShow[adjustedIndex]);
          }
          if (controller.hasMore) {
            return const EventListLoader();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Text(
              localizations.noMoreEventsFound,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.grey),
            ),
          );
        },
      ),
    );
  }
}
