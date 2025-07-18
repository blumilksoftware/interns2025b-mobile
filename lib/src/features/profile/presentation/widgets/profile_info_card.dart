import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/avatar_widget.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/profile_edit_section.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/profile_info_content.dart';

class ProfileInfoCard extends ConsumerWidget {
  const ProfileInfoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final topPadding = MediaQuery.of(context).padding.top;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: screenHeight - topPadding - 170,
          ),
          padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ProfileInfoContent(),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: ProfileEditSection(),
              ),
            ],
          ),
        ),
        Positioned(
          top: -50,
          left: (MediaQuery.of(context).size.width - 100) / 2,
          child: const AvatarWidget(),
        ),
      ],
    );
  }
}
