import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/profile/domain/providers/get_user_profile_usecase_provider.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/user_model.dart';

final userProfileByIdProvider = FutureProvider.family<User, int>((
  ref,
  userId,
) async {
  final useCase = ref.watch(getUserProfileUseCaseProvider);
  return useCase(userId);
});
