import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/stat_tile.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/user_model.dart';

class ProfileStats extends StatelessWidget {
  final User user;

  const ProfileStats({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StatTile(label: localizations.eventsCount, value: user.eventsCount),
        const SizedBox(width: 16),
        StatTile(
          label: localizations.followersCount,
          value: user.followersCount,
        ),
        const SizedBox(width: 16),
        StatTile(
          label: localizations.followingCount,
          value: user.followingCount,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
