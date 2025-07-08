import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:interns2025b_mobile/src/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/user_model.dart';
import 'package:interns2025b_mobile/src/core/exceptions/http_exception.dart';
import 'package:interns2025b_mobile/src/core/exceptions/no_internet_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends ChangeNotifier {
  final UpdateProfileUseCase updateProfileUseCase;
  final GetProfileUseCase getProfileUseCase;

  ProfileController(this.updateProfileUseCase, this.getProfileUseCase);

  bool _isEditing = false;
  bool get isEditing => _isEditing;

  User? _user;
  User? get user => _user;

  Future<void> fetchUserProfile({BuildContext? context}) async {
    final messenger = context != null ? ScaffoldMessenger.of(context) : null;
    final localizations = context != null
        ? AppLocalizations.of(context)!
        : null;

    try {
      _user = await getProfileUseCase();
      notifyListeners();
    } on NoInternetException catch (_) {
      if (context != null && context.mounted) {
        messenger?.showSnackBar(
          SnackBar(content: Text(localizations!.noInternetError)),
        );
      }
    } on HttpException catch (e) {
      if (context != null && context.mounted) {
        messenger?.showSnackBar(SnackBar(content: Text(e.message)));
      }
    } catch (_) {
      if (context != null && context.mounted) {
        messenger?.showSnackBar(
          SnackBar(content: Text(localizations!.genericError)),
        );
      }
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
        lastName: (lastName != null && lastName.trim().isNotEmpty)
            ? lastName.trim()
            : null,
      );

      await fetchUserProfile();

      if (_user != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', jsonEncode(_user!.toJson()));
      }

      if (context.mounted) {
        messenger.showSnackBar(
          SnackBar(content: Text(localizations.profileUpdateSuccess)),
        );
      }

      toggleEdit();
    } on NoInternetException {
      messenger.showSnackBar(
        SnackBar(content: Text(localizations.noInternetError)),
      );
    } on HttpException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    } catch (_) {
      messenger.showSnackBar(
        SnackBar(content: Text(localizations.profileUpdateError)),
      );
    }
  }
}
