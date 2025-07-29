import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/providers/profile_controller_provider.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/avatar_widget.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/profile_edit_section.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/profile_info_content.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';

class ProfileInfoCard extends ConsumerWidget {
  const ProfileInfoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
          decoration: BoxDecoration(
            color: AppColors.backgroundLight,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                ProfileInfoContent(),
                SizedBox(height: 24),
                ProfileEditSection(),
              ],
            ),
          ),
        ),
        Positioned(
          top: -50,
          left: (MediaQuery.of(context).size.width - 100) / 2,
          child: Consumer(
            builder: (context, ref, _) {
              final user = ref.watch(profileControllerProvider).user;
              return AvatarWidget(avatarUrl: user?.avatarUrl);
            },
          ),
        ),
      ],
    );
  }
}
