import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_location_map_provider.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_marker.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/pin_map_title_layer.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/zoom_controls.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_model.dart';
import 'package:latlong2/latlong.dart';

class EventLocationMap extends ConsumerWidget {
  final Event event;

  const EventLocationMap({super.key, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (event.latitude == null || event.longitude == null) {
      return const SizedBox();
    }
    final eventLatLng = LatLng(event.latitude!, event.longitude!);
    final mapState = ref.watch(eventLocationMapProvider);
    final mapController = mapState.mapController;

    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: eventLatLng,
              initialZoom: mapState.zoom,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
              ),
            ),
            children: [
              const PinMapTitleLayer(),
              MarkerLayer(
                markers: [EventMarker(event: event, onTap: () {})],
              ),
            ],
          ),

          Positioned(
            bottom: 8,
            right: 8,
            child: ZoomControls(provider: eventLocationMapProvider),
          ),
        ],
      ),
    );
  }
}
