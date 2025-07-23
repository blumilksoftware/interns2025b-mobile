import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';

class AvatarWidget extends StatelessWidget {
  final String? avatarUrl;
  final double size;

  const AvatarWidget({
    super.key,
    this.avatarUrl,
    this.size = 100,
  });

  @override
  Widget build(BuildContext context) {
    final isValidUrl = avatarUrl != null && avatarUrl!.trim().isNotEmpty;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.backgroundLight, width: 3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: isValidUrl
            ? Image.network(
          avatarUrl!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _fallbackAvatar(),
        )
            : _fallbackAvatar(),
      ),
    );
  }

  Widget _fallbackAvatar() {
    return Container(
      color: AppColors.lightGrey,
      child: Icon(Icons.person, size: 48, color: AppColors.grey),
    );
  }
}