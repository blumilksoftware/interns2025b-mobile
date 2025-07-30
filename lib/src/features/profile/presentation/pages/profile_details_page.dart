import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/providers/user_profile_by_id_provider.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/profile_details/profile_details_events.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/profile_details/profile_details_header.dart';

class ProfileDetailsPage extends ConsumerWidget {
  const ProfileDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ModalRoute.of(context)!.settings.arguments as int;

    final userAsyncValue = ref.watch(userProfileByIdProvider(userId));

    return userAsyncValue.when(
      data: (user) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                ProfileDetailsHeader(user: user),
                ProfileDetailsEvents(events: user.events),
              ],
            ),
          ),
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, _) => Scaffold(
        body: Center(child: Text('Nie udało się załadować profilu: $error')),
      ),
    );
  }
}
