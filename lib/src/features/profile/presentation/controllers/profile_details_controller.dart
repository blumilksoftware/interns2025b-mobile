import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/providers/profile_details_user_provider.dart';

class ProfileDetailsController extends ChangeNotifier {
  final Ref ref;
  final GetUserProfileUseCase getUserProfileUseCase;

  ProfileDetailsController(this.ref, this.getUserProfileUseCase);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadUserById(int userId, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    final messenger = ScaffoldMessenger.of(context);

    try {
      final user = await getUserProfileUseCase(userId);
      ref.read(profileDetailsUserProvider.notifier).state = user;
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text('Nie udało się załadować profilu użytkownika: $e'),
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
