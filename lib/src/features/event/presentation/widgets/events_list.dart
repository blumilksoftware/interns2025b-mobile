import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_controller_provider.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_scroll_controller_provider.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_card.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_list_loader.dart';
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

    return RefreshIndicator(
      onRefresh: () => notifier.loadEvents(refresh: true),
      child: ListView.builder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: controller.events.length + (controller.hasMore ? 1 : 0) + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: LabeledText(
                localizations.searchEvents,
                isBold: true,
                fontSize: 22,
              ),
            );
          }

          final actualIndex = index - 1;

          if (actualIndex < controller.events.length) {
            final event = controller.events[actualIndex];
            return EventCard(event: event);
          } else {
            return const EventListLoader();
          }
        },
      ),
    );
  }
}
