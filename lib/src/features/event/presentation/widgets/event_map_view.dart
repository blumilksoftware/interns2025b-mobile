import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_controller_provider.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_cluster_marker.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_marker.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/pin_map_title_layer.dart';
import 'package:latlong2/latlong.dart';

class EventMapView extends ConsumerStatefulWidget {
  const EventMapView({super.key});

  @override
  ConsumerState<EventMapView> createState() => _EventMapViewState();
}

class _EventMapViewState extends ConsumerState<EventMapView> {
  final MapController _mapController = MapController();

  static final LatLngBounds legnicaBounds = LatLngBounds(
    LatLng(51.14, 16.06),
    LatLng(51.28, 16.26),
  );

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventsControllerProvider).filteredEvents;

    final markers = events
        .where((e) => e.latitude != null && e.longitude != null)
        .map((e) => EventMarker(event: e))
        .toList();

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: LatLng(51.21006, 16.1619),
        initialZoom: 13,
        minZoom: 10,
        maxZoom: 21,
        cameraConstraint: CameraConstraint.contain(bounds: legnicaBounds),
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        ),
      ),
      children: [
        const PinMapTitleLayer(),
        MarkerClusterLayerWidget(
          options: MarkerClusterLayerOptions(
            markers: markers,
            maxClusterRadius: 200,
            size: const Size(40, 40),
            builder: (context, cluster) =>
                EventClusterMarker(count: cluster.length),
          ),
        ),
      ],
    );
  }
}
