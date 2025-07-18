import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';

class EventImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const EventImage({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _placeholder();
    }

    Widget image = Image.network(
      imageUrl!,
      width: width ?? double.infinity,
      height: height ?? 129,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => _placeholder(),
    );

    if (borderRadius != null) {
      image = ClipRRect(
        borderRadius: borderRadius!,
        child: image,
      );
    }

    return image;
  }

  Widget _placeholder() {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 129,
      color: AppColors.lightGrey,
      child: const Icon(
        Icons.image_not_supported,
        size: 64,
        color: AppColors.grey,
      ),
    );
  }
}
