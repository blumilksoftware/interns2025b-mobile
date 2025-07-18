import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';

class EventImage extends StatelessWidget {
  final String? imageUrl;

  const EventImage({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return const SizedBox.shrink();
    }
    return Image.network(
      imageUrl!,
      width: double.infinity,
      height: 129,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: double.infinity,
          height: 129,
          color: AppColors.lightGrey,
          child: const Icon(
            Icons.image_not_supported,
            size: 64,
            color: AppColors.grey,
          ),
        );
      },
    );
  }
}
