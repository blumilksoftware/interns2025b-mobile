import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class PinMapTitleLayer extends StatelessWidget {
  const PinMapTitleLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.example.interns2025b_mobile',
    );
  }
}
