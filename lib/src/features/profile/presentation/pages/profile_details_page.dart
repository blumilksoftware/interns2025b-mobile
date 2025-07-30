import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/providers/user_profile_by_id_provider.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/profile_info_card.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/navigation_bar.dart';

class ProfileDetailsPage extends ConsumerWidget {
  const ProfileDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ModalRoute.of(context)!.settings.arguments as int;
    final topPadding = MediaQuery.of(context).padding.top;
    final localization = AppLocalizations.of(context)!.failedToLoadUserProfile;

    final userAsyncValue = ref.watch(userProfileByIdProvider(userId));

    return userAsyncValue.when(
      data: (user) {
        return Scaffold(
          body: Stack(
            children: [
              Container(color: AppColors.primary),
              Positioned.fill(
                top: 0,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: topPadding + 100),
                      ProfileInfoCard(user: user, editable: false),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: const NavigationBarWidget(),
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, _) => Scaffold(
        body: Center(
          child: Text(localization.replaceAll('{e}', error.toString())),
        ),
      ),
    );
  }
}
