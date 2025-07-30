import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/core/routes/app_routes.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_owner.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/user_model.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';

class EventAuthorTile extends StatelessWidget {
  final EventOwner owner;

  const EventAuthorTile({super.key, required this.owner});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (owner is User) {
          Navigator.of(
            context,
          ).pushNamed(AppRoutes.profileDetails, arguments: (owner as User).id);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
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
                child: owner.avatarUrl != null && owner.avatarUrl!.isNotEmpty
                    ? Image.network(
                        owner.avatarUrl!,
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
                owner.displayName,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _defaultAvatar() =>
      Icon(Icons.person, size: 24, color: AppColors.primary);
}
