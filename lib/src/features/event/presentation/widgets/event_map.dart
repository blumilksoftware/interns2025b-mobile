import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/event_cluster_marker.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/pin_map_title_layer.dart';
import 'package:latlong2/latlong.dart';

class EventMap extends StatelessWidget {
  final MapController mapController;
  final List<Marker> markers;
  final void Function(TapPosition, LatLng)? onMapTap;

  const EventMap({
    super.key,
    required this.mapController,
    required this.markers,
    this.onMapTap,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: LatLng(51.21006, 16.1619),
        initialZoom: 13,
        minZoom: 10,
        maxZoom: 24,
        cameraConstraint: CameraConstraint.contain(
          bounds: LatLngBounds(LatLng(51.14, 16.06), LatLng(51.28, 16.26)),
        ),
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        ),
        onTap: onMapTap,
      ),
      children: [
        const PinMapTitleLayer(),
        MarkerClusterLayerWidget(
          options: MarkerClusterLayerOptions(
            maxClusterRadius: 150,
            size: const Size(40, 40),
            markers: markers,
            builder: (context, clusterMarkers) =>
                EventClusterMarker(count: clusterMarkers.length),
          ),
        ),
      ],
    );
  }
}
