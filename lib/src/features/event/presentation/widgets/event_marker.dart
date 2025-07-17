import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_model.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';
import 'package:latlong2/latlong.dart';

class EventMarker extends Marker {
  EventMarker({required Event event})
    : super(
        key: ValueKey(event.id),
        point: LatLng(event.latitude!, event.longitude!),
        width: 40,
        height: 40,
        alignment: Alignment.center,
        child: Tooltip(
          message: event.title,
          child: const Icon(
            Icons.location_on,
            color: AppColors.primary,
            size: 36,
          ),
        ),
      );
}
