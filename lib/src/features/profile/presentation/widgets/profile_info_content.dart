import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/profile/domain/utils/event_sorter.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/providers/profile_controller_provider.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/profile_events_section.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/profile_stats.dart';

class ProfileInfoContent extends ConsumerWidget {
  const ProfileInfoContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(profileControllerProvider).user;

    if (user == null) return const SizedBox();

    final sortedEvents = [...user.events];
    sortEvents(sortedEvents);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        Text(
          user.firstName,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        if ((user.lastName?.trim().isNotEmpty ?? false))
          Text(
            user.lastName!,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,

          ),
        const SizedBox(height: 24),

        ProfileStats(),
        ProfileEventsSection(events: sortedEvents),
      ],
    );
  }
}
