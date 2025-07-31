import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/avatar_widget.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/profile_info_content.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/user_model.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';

class ProfileInfoCard extends StatelessWidget {
  final User? user;
  final bool editable;

  const ProfileInfoCard({super.key, this.user, this.editable = true});

  @override
  Widget build(BuildContext context) {
    final effectiveUser = user;

    if (effectiveUser == null) return const SizedBox();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final screenHeight = MediaQuery.of(context).size.height;
            final navBarHeight = kBottomNavigationBarHeight;

            return Container(
              constraints: BoxConstraints(
                minHeight: screenHeight - navBarHeight,
              ),
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: ProfileInfoContent(
                user: effectiveUser,
                editable: editable,
              ),
            );
          },
        ),
        Positioned(
          top: -50,
          left: (MediaQuery.of(context).size.width - 100) / 2,
          child: AvatarWidget(avatarUrl: effectiveUser.avatarUrl),
        ),
      ],
    );
  }
}
