import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/providers/auth_controller_provider.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/button.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.read(authControllerProvider.notifier);
    final isLoading = ref.watch(authControllerProvider).isLoading;
    final localizations = AppLocalizations.of(context)!;

    return Button(
      label: localizations.logout,
      icon: Icons.logout,
      isLoading: isLoading,
      fullWidth: true,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textLight,
      onPressed: () async {
        await authController.logout(context);
      },
    );
  }
}
