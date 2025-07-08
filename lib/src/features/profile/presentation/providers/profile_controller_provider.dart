import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/profile/domain/providers/get_profile_usecase_provider.dart';
import 'package:interns2025b_mobile/src/features/profile/domain/providers/update_profile_usecase_provider.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/controllers/profile_controller.dart';

final profileControllerProvider = ChangeNotifierProvider<ProfileController>((
  ref,
) {
  final getProfileUseCase = ref.watch(getProfileUseCaseProvider);
  final updateProfileUseCase = ref.watch(updateProfileUseCaseProvider);
  return ProfileController(updateProfileUseCase, getProfileUseCase);
});
