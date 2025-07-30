import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/profile/domain/providers/get_user_profile_usecase_provider.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/controllers/profile_details_controller.dart';

final profileDetailsControllerProvider =
    ChangeNotifierProvider<ProfileDetailsController>((ref) {
      final useCase = ref.watch(getUserProfileUseCaseProvider);
      return ProfileDetailsController(ref, useCase);
    });
