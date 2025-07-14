import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/providers/profile_controller_provider.dart';

class ProfileInfoContent extends ConsumerWidget {
  const ProfileInfoContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(profileControllerProvider).user;

    if (user == null) return const SizedBox();

    return Column(
      children: [
        const SizedBox(height: 24),
        Text(
          user.lastName?.trim().isNotEmpty == true
              ? '${user.firstName} ${user.lastName}'
              : user.firstName,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
