import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/providers/profile_controller_provider.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/profile_info_card.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/navigation_bar.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topPadding = MediaQuery.of(context).padding.top;
    final user = ref.watch(profileControllerProvider).user;
    final profileInit = ref.watch(profileInitProvider);
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          Container(color: AppColors.primary),
          profileInit.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(
              child: Text(
                localization.failedToLoadUserProfile.replaceAll(
                  '{e}',
                  error.toString(),
                ),
                style: TextStyle(color: AppColors.red),
              ),
            ),
            data: (_) {
              if (user == null) {
                return const Center(child: CircularProgressIndicator());
              }

              return Positioned.fill(
                top: 0,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: topPadding + 100),
                      ProfileInfoCard(user: user, editable: true),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: const NavigationBarWidget(),
    );
  }
}
