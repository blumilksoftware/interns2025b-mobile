import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_controller_provider.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_search_controller_provider.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_view_mode_provider.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_serach_bar.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/events_list.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/toggle_view_mode_switch.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/navigation_bar.dart';

class EventPage extends ConsumerWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = ref.watch(eventSearchControllerProvider);
    final eventController = ref.read(eventsControllerProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Column(
          children: [
            EventSearchBar(
              controller: searchController,
              onChanged: eventController.updateSearchQuery,
            ),
            const SizedBox(height: 16),
            const ToggleViewModeSwitch(),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer(
                builder: (context, ref, _) {
                  final mode = ref.watch(eventViewModeProvider);
                  if (mode == EventViewMode.list) {
                    return EventsList();
                  } else {
                    return const Center(child: Text('Widok mapy (TODO)'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavigationBarWidget(),
    );
  }
}
