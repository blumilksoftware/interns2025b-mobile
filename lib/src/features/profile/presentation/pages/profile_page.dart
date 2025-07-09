import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/profile_edit_section.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/profile_info_card.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topPadding = MediaQuery.of(context).padding.top;

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

                  const ProfileInfoCard(),

                  const SizedBox(height: 24),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: ProfileEditSection(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
