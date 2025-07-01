import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/core/exceptions/auth_exception.dart';
import 'package:interns2025b_mobile/src/core/exceptions/no_internet_exception.dart';
import 'package:interns2025b_mobile/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:interns2025b_mobile/src/features/auth/domain/usecases/register_usecase.dart';
import 'package:interns2025b_mobile/src/core/routes/app_routes.dart';
import 'package:interns2025b_mobile/src/core/exceptions/http_exception.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ChangeNotifier {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;

  AuthController({required this.registerUseCase, required this.loginUseCase});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  User? _user;
  User? get user => _user;

  bool get isLoggedIn => _user != null;

  Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final localizations = AppLocalizations.of(context)!;
    _isLoading = true;
    notifyListeners();

    try {
      await loginUseCase(email, password);
      await loadUser();

      if (!context.mounted) return;

      navigator.pushReplacementNamed(AppRoutes.home);
      messenger.showSnackBar(
        SnackBar(content: Text(localizations.loginSuccess)),
      );
    } on NoInternetException catch (e) {
      if (context.mounted) {
        _showError(context, e.message);
      }
    } on AuthException catch (e) {
      if (context.mounted) {
        _showError(context, e.message);
      }
    } on HttpException catch (e) {
      if (context.mounted) {
        _showError(context, e.message);
      }
    } catch (_) {
      if (context.mounted) {
        _showError(context, localizations.unknownError);
      }
    }

    _isLoading = false;
    notifyListeners();
  }

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
