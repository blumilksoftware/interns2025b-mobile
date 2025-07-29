import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/providers/profile_controller_provider.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';
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
      backgroundColor: AppColors.red,
      foregroundColor: AppColors.backgroundLight,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(localizations.profileDeleteRequestButtonLabel),
            content: Text(localizations.profileDeleteRequestDialogContent),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(localizations.cancel),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await profileController.deleteUser(context: context);
                },
                child: Text(
                  localizations.confirm,
                  style: TextStyle(color: AppColors.red),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
