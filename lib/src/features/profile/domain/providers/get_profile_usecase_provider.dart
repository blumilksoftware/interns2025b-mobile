import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/profile/data/providers/profile_repository_provider.dart';
import 'package:interns2025b_mobile/src/features/profile/domain/usecases/get_profile_usecase.dart';

final getProfileUseCaseProvider = Provider<GetProfileUseCase>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return GetProfileUseCase(repository);
});
