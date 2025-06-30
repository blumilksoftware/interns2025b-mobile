import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/auth/domain/usecases/register_usecase.dart';
import 'package:interns2025b_mobile/src/core/routes/app_routes.dart';
import 'package:interns2025b_mobile/src/core/exceptions/http_exception.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ChangeNotifier {
  final RegisterUseCase registerUseCase;

  AuthController({required this.registerUseCase});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  User? _user;
  User? get user => _user;

  bool get isLoggedIn => _user != null;

  Future<void> register(
    BuildContext context,
    String email,
    String firstName,
    String? lastName,
    String password,
    String confirmPassword,
  ) async {
    _isLoading = true;
    notifyListeners();
    final localizations = AppLocalizations.of(context)!;
    try {
      await registerUseCase(
        email,
        firstName,
        lastName,
        password,
        confirmPassword,
      );
      if (!context.mounted) return;

      Navigator.pushReplacementNamed(context, AppRoutes.login);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(localizations.loginSuccess)));
    } on HttpException catch (e) {
      if (!context.mounted) return;
      _showError(context, e.message);
    } catch (_) {
      if (!context.mounted) return;
      _showError(context, localizations.unknownError);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      _user = User.fromJson(jsonDecode(userJson));
    } else {
      _user = null;
    }
    notifyListeners();
  }

  void _showError(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    }
  }
}
