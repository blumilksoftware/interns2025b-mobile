import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/profile/data/providers/profile_repository_provider.dart';
import 'package:interns2025b_mobile/src/features/profile/domain/usecases/get_user_profile_usecase.dart';

final getUserProfileUseCaseProvider = Provider<GetUserProfileUseCase>((ref) {
  final repo = ref.watch(profileRepositoryProvider);
  return GetUserProfileUseCase(repo);
});
