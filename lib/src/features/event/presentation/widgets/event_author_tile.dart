import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/organization_model.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/user_model.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';

class EventAuthorTile extends StatelessWidget {
  final dynamic owner;

  const EventAuthorTile({super.key, required this.owner});

  @override
  Widget build(BuildContext context) {
    if (owner == null) return const SizedBox.shrink();

    String? name;
    String? imageUrl;

    if (owner is User) {
      name = owner.firstName + (owner.lastName != null ? ' ${owner.lastName}' : '');
      imageUrl = owner.avatarUrl;
    } else if (owner is Organization) {
      name = owner.name;
      imageUrl = owner.avatarUrl;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 48,
              height: 48,
              color: AppColors.primary.withValues(alpha: 0.1),
              child: imageUrl != null && imageUrl.isNotEmpty
                  ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _defaultAvatar();
                },
              )
                  : _defaultAvatar(),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name ?? '',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _defaultAvatar() {
    return Icon(Icons.person, size: 24, color: AppColors.primary);
  }
}
