import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';

class EventClusterMarker extends StatelessWidget {
  final int count;

  const EventClusterMarker({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        count.toString(),
        style: const TextStyle(
          color: AppColors.backgroundLight,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
