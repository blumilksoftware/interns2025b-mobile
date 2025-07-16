import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class EventMapView extends StatefulWidget {
  const EventMapView({super.key});

  @override
  State<EventMapView> createState() => _EventMapViewState();
}

class _EventMapViewState extends State<EventMapView> {
  final MapController _mapController = MapController();

  final LatLngBounds legnicaBounds = LatLngBounds(
    LatLng(51.14, 16.06),
    LatLng(51.28, 16.26),
  );

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: LatLng(51.21006, 16.1619),
        initialZoom: 13,
        minZoom: 12,
        maxZoom: 17,
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
      ],
    );
  }
}
