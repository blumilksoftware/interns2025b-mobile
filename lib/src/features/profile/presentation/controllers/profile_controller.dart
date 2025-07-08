import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/user_model.dart';
import 'package:interns2025b_mobile/src/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:interns2025b_mobile/src/features/profile/domain/usecases/update_profile_usecase.dart';

class ProfileController extends ChangeNotifier {
  final UpdateProfileUseCase updateProfileUseCase;
  final GetProfileUseCase getProfileUseCase;

  ProfileController(this.updateProfileUseCase, this.getProfileUseCase);

  bool _isEditing = false;

  bool get isEditing => _isEditing;

  User? _user;

  User? get user => _user;

  Future<void> fetchUserProfile() async {
    try {
      _user = await getProfileUseCase();
      notifyListeners();
    } catch (e, st) {
      debugPrint('Błąd podczas pobierania profilu: $e');
      debugPrintStack(stackTrace: st);
    }
  }

  void toggleEdit() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  Future<void> updateProfile({
    required BuildContext context,
    String? firstName,
    String? lastName,
  }) async {
    final messenger = ScaffoldMessenger.of(context);
    final localizations = AppLocalizations.of(context)!;

    try {
      await updateProfileUseCase(
        context: context,
        firstName: firstName,
        lastName: lastName,
      );

      await fetchUserProfile();

      final prefs = await SharedPreferences.getInstance();
      if (_user != null) {
        await prefs.setString('user', jsonEncode(_user!.toJson()));
      }

      if (context.mounted) {
        messenger.showSnackBar(
          SnackBar(content: Text(localizations.profileUpdateSuccess)),
        );
      }

      toggleEdit();
    } catch (e, st) {
      debugPrint('Błąd aktualizacji profilu: $e');
      debugPrintStack(stackTrace: st);
      if (context.mounted) {
        messenger.showSnackBar(
          SnackBar(content: Text(localizations.profileUpdateError)),
        );
      }
    }
  }
}
