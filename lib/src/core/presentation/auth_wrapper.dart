import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/pages/login_page.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/pages/event_page.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/providers/profile_user_provider.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/user_model.dart';

class AuthWrapper extends ConsumerWidget {
  final User? user;
  const AuthWrapper({super.key, this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(profileUserProvider);
    if (user == null) {
      return const LoginPage();
    } else {
      return const EventPage();
    }
  }
}
