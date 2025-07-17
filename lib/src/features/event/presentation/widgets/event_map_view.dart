import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_controller_provider.dart';
import 'package:latlong2/latlong.dart';

class EventMapView extends ConsumerStatefulWidget {
  const EventMapView({super.key});

  @override
  ConsumerState<EventMapView> createState() => _EventMapViewState();
}

class _EventMapViewState extends ConsumerState<EventMapView> {
  final MapController _mapController = MapController();

  final LatLngBounds legnicaBounds = LatLngBounds(
    LatLng(51.14, 16.06),
    LatLng(51.28, 16.26),
  );

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventsControllerProvider).filteredEvents;

    final markers = events
        .where((e) => e.latitude != null && e.longitude != null)
        .map((e) => Marker(
      key: ValueKey(e.id),
      point: LatLng(e.latitude!, e.longitude!),
      width: 40,
      height: 40,
      alignment: Alignment.center,
      child: Tooltip(
        message: e.title,
        child: const Icon(
          Icons.location_on,
          color: Colors.red,
          size: 36,
        ),
      ),
    ))
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
        initialRotation: 0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.interns2025b_mobile',
        ),
        MarkerClusterLayerWidget(
          options: MarkerClusterLayerOptions(
            markers: markers,
            maxClusterRadius: 40,
            size: const Size(40, 40),
            builder: (context, cluster) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  cluster.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              );
            },
          ),

        ),
      ],
    );
  }
}
