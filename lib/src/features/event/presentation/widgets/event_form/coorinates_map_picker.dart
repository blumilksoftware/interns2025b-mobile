import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/widgets/pin_map_title_layer.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/labeled_text.dart';
import 'package:latlong2/latlong.dart';

class CoordinatesMapPicker extends StatefulWidget {
  final TextEditingController latitude;
  final TextEditingController longitude;

  const CoordinatesMapPicker({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<CoordinatesMapPicker> createState() => _CoordinatesMapPickerState();
}

class _CoordinatesMapPickerState extends State<CoordinatesMapPicker> {
  late LatLng _selectedPosition;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    final lat = double.tryParse(widget.latitude.text) ?? 51.2081;
    final lng = double.tryParse(widget.longitude.text) ?? 16.1603;
    _selectedPosition = LatLng(lat, lng);
  }

  void _updatePosition(LatLng newPos) {
    setState(() => _selectedPosition = newPos);
    widget.latitude.text = newPos.latitude.toStringAsFixed(6);
    widget.longitude.text = newPos.longitude.toStringAsFixed(6);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabeledText(localizations.selectPointonMapLabel),
        const SizedBox(height: 8),
        SizedBox(
          height: 250,
          child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _selectedPosition,
              initialZoom: 15,
              minZoom: 10,
              maxZoom: 24,
              cameraConstraint: CameraConstraint.contain(
                bounds: LatLngBounds(LatLng(51.14, 16.06), LatLng(51.28, 16.26)),
              ),
              onTap: (tapPos, point) => _updatePosition(point),
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              ),
            ),
            children: [
            PinMapTitleLayer(),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _selectedPosition,
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.location_on, size: 40, color: AppColors.primary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
