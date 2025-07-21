import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';

class ZoomControls extends ConsumerWidget {
  final dynamic provider;

  const ZoomControls({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapNotifier = ref.read(provider.notifier);

    return Column(
      children: [
        FloatingActionButton(
          mini: true,
          heroTag: '${provider.hashCode}_zoom_in',
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.backgroundLight,
          onPressed: mapNotifier.zoomIn,
          child: const Icon(Icons.add),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          mini: true,
          heroTag: '${provider.hashCode}_zoom_out',
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.backgroundLight,
          onPressed: mapNotifier.zoomOut,
          child: const Icon(Icons.remove),
        ),
      ],
    );
  }
}
