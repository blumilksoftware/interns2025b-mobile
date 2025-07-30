import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:interns2025b_mobile/src/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/providers/profile_details_user_provider.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/providers/profile_user_provider.dart';

class ProfileDetailsController extends ChangeNotifier {
  final Ref ref;
  final GetUserProfileUseCase getUserProfileUseCase;
  final GetProfileUseCase getProfileUseCase;

  ProfileDetailsController(
      this.ref,
      this.getUserProfileUseCase,
      this.getProfileUseCase,
      );

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadUserById(int userId, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

      final currentUser = ref.read(profileUserProvider);
      final isSelf = currentUser != null && currentUser.id == userId;

      final user = isSelf
          ? await getProfileUseCase()
          : await getUserProfileUseCase(userId);

      ref.read(profileDetailsUserProvider.notifier).state = user;

    }
}
