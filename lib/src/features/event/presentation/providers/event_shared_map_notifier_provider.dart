import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapState {
  final MapController mapController;
  final double zoom;

  MapState({required this.mapController, required this.zoom});

  MapState copyWith({MapController? mapController, double? zoom}) {
    return MapState(
      mapController: mapController ?? this.mapController,
      zoom: zoom ?? this.zoom,
    );
  }
}

class MapNotifier extends StateNotifier<MapState> {
  MapNotifier() : super(MapState(mapController: MapController(), zoom: 15.0));

  void zoomIn() => _setZoom(state.zoom + 1);

  void zoomOut() => _setZoom(state.zoom - 1);

  void _setZoom(double zoom) {
    final clampedZoom = zoom.clamp(1.0, 18.0);
    state.mapController.move(state.mapController.camera.center, clampedZoom);
    state = state.copyWith(zoom: clampedZoom);
  }
}
