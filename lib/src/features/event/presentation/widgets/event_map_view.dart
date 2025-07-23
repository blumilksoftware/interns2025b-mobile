import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_controller_provider.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_map_provider.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_bottom_card.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_map.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_marker.dart';

class EventMapView extends ConsumerStatefulWidget {
  const EventMapView({super.key});

  @override
  ConsumerState<EventMapView> createState() => _EventMapViewState();
}

class _EventMapViewState extends ConsumerState<EventMapView> {
  bool _initialized = false;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(eventsControllerProvider.notifier).loadAllEvents();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(eventsControllerProvider.notifier);
    final state = ref.watch(eventsControllerProvider);
    final mapController = ref.watch(eventMapProvider).mapController;
    final events = state.filteredEvents;
    final selectedEvent = state.selectedEvent;

    final markers = events
        .where((e) => e.latitude != null && e.longitude != null)
        .map(
          (e) => EventMarker(event: e, onTap: () => controller.selectEvent(e)),
        )
        .toList();

    return Stack(
      children: [
        EventMap(
          mapController: mapController,
          markers: markers,
          onMapTap: (_, _) => controller.selectEvent(null),
        ),
        if (selectedEvent != null)
          Positioned(
            left: 16,
            right: 16,
            bottom: 10,
            child: EventBottomCard(
              event: selectedEvent,
              onClose: () => controller.selectEvent(null),
            ),
          ),
      ],
    );
  }
}
