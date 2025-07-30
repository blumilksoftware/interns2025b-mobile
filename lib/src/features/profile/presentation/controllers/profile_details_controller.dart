import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/providers/profile_details_user_provider.dart';

class ProfileDetailsController extends ChangeNotifier {
  final Ref ref;
  final GetUserProfileUseCase getUserProfileUseCase;

  ProfileDetailsController(this.ref, this.getUserProfileUseCase);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadUserById(int userId, BuildContext context) async {
    final localization = AppLocalizations.of(context)!;
    _isLoading = true;
    notifyListeners();
    final messenger = ScaffoldMessenger.of(context);

    try {
      final user = await getUserProfileUseCase(userId);
      ref.read(profileDetailsUserProvider.notifier).state = user;
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            localization.failedToLoadUserProfile.replaceAll(
              '{e}',
              e.toString(),
            ),
          ),
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
