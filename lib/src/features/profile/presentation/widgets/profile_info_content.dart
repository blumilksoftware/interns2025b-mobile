import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/providers/profile_controller_provider.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/button.dart';

class ProfileInfoContent extends ConsumerWidget {
  const ProfileInfoContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(profileControllerProvider).user;
    final controller = ref.watch(profileControllerProvider);
    final notifier = ref.read(profileControllerProvider.notifier);

    if (user == null) return const SizedBox();

    return Column(
      children: [
        const SizedBox(height: 24),
        Text(
          '${user.firstName} ${user.lastName}',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Button(
          label: controller.isEditing
              ? AppLocalizations.of(context)!.cancel
              : AppLocalizations.of(context)!.editProfile,
          icon: controller.isEditing ? Icons.close : Icons.edit,
          fullWidth: true,
          onPressed: notifier.toggleEdit,
        ),
      ],
    );
  }
}
