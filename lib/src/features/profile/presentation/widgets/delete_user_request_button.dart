import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/providers/profile_controller_provider.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/button.dart';

class DeleteUserRequestButton extends ConsumerWidget {
  const DeleteUserRequestButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileController = ref.watch(profileControllerProvider.notifier);
    final isLoading = ref.watch(profileControllerProvider).isLoading;
    final localizations = AppLocalizations.of(context)!;

    return Button(
      label: localizations.profileDeleteRequestButtonLabel,
      icon: Icons.delete_forever,
      isLoading: isLoading,
      fullWidth: true,
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      onPressed: () async {
        await profileController.deleteUser(context: context);
      },
    );
  }
}
