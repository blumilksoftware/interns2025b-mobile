import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/providers/profile_controller_provider.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/stat_tile.dart';

class ProfileStats extends ConsumerWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(profileControllerProvider).user;
    final localizations = AppLocalizations.of(context)!;

    if (user == null) return const SizedBox();

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
        const SizedBox(height: 24),
      ],
    );
  }
}
