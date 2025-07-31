import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/features/profile/domain/utils/event_sorter.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/profile_edit_section.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/profile_events_section.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/profile_stats.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/user_model.dart';

class ProfileInfoContent extends StatelessWidget {
  final User user;
  final bool editable;

  const ProfileInfoContent({
    super.key,
    required this.user,
    this.editable = true,
  });

  @override
  Widget build(BuildContext context) {
    final sortedEvents = [...user.events];
    sortEvents(sortedEvents);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        Text(
          user.firstName,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        if ((user.lastName?.trim().isNotEmpty ?? false))
          Text(
            user.lastName!,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        const SizedBox(height: 24),
        ProfileStats(user: user),
        ProfileEventsSection(events: sortedEvents),
        if (editable) ...[
          const SizedBox(height: 24),
          const ProfileEditSection(),
        ],
      ],
    );
  }
}
