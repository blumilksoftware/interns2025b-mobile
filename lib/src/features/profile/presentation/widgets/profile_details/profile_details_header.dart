import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/user_model.dart';

class ProfileDetailsHeader extends StatelessWidget {
  final User user;

  const ProfileDetailsHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (user.avatarUrl != null)
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(user.avatarUrl!),
          ),
        const SizedBox(height: 16),
        Text(user.firstName, style: Theme.of(context).textTheme.headlineSmall),
        if ((user.lastName?.trim().isNotEmpty ?? false))
          Text(
            user.lastName!,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
      ],
    );
  }
}
