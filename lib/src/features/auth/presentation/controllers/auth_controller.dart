import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/core/exceptions/auth_exception.dart';
import 'package:interns2025b_mobile/src/core/exceptions/http_exception.dart';
import 'package:interns2025b_mobile/src/core/exceptions/no_internet_exception.dart';
import 'package:interns2025b_mobile/src/core/exceptions/unauthorized_exception.dart';
import 'package:interns2025b_mobile/src/core/routes/app_routes.dart';
import 'package:interns2025b_mobile/src/features/auth/domain/providers/forgot_password_usecase_provider.dart';
import 'package:interns2025b_mobile/src/features/auth/domain/providers/login_usecase_provider.dart';
import 'package:interns2025b_mobile/src/features/auth/domain/providers/logout_usecase_provider.dart';
import 'package:interns2025b_mobile/src/features/auth/domain/providers/register_usecase_provider.dart';
import 'package:interns2025b_mobile/src/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:interns2025b_mobile/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:interns2025b_mobile/src/features/auth/domain/usecases/logout_usecase.dart';
import 'package:interns2025b_mobile/src/features/auth/domain/usecases/register_usecase.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/providers/profile_user_provider.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/user_model.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends AsyncNotifier<User?> {
  late final RegisterUseCase _registerUseCase = ref.read(
    registerUseCaseProvider,
  );
  late final LoginUseCase _loginUseCase = ref.read(loginUseCaseProvider);
  late final LogoutUseCase _logoutUseCase = ref.read(logoutUseCaseProvider);
  late final ForgotPasswordUseCase _forgotPasswordUseCase = ref.read(
    forgotPasswordUseCaseProvider,
  );

  @override
  Future<User?> build() async {
    return _loadUser();
  }

  Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    final localizations = AppLocalizations.of(context)!;
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    state = const AsyncLoading();

    try {
      await _loginUseCase(email, password);
      final user = await _loadUser();
      ref.read(profileUserProvider.notifier).state = user;
      state = AsyncData(user);

      if (context.mounted) {
        navigator.pushReplacementNamed(AppRoutes.events);
        messenger.showSnackBar(
          SnackBar(content: Text(localizations.loginSuccess)),
        );
      }
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      if (context.mounted) {
        _showError(context, _resolveErrorMessage(e, localizations));
      }
    }
  }

  Future<void> register(
    BuildContext context,
    String email,
    String firstName,
    String? lastName,
    String password,
    String confirmPassword,
  ) async {
    final localizations = AppLocalizations.of(context)!;

    state = const AsyncLoading();

    try {
      await _registerUseCase(
        email,
        firstName,
        lastName,
        password,
        confirmPassword,
      );
      state = AsyncData(await build());

      if (context.mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(localizations.registerSuccess)));
      }
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      if (context.mounted) {
        _showError(context, _resolveErrorMessage(e, localizations));
      }
    }
  }

  Future<void> logout(BuildContext context) async {
    final localizations = AppLocalizations.of(context)!;
    final navigator = Navigator.of(context);

    state = const AsyncLoading();

    try {
      await _logoutUseCase();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('user');
      ref.read(profileUserProvider.notifier).state = null;


      state = const AsyncData(null);

      if (context.mounted) {
        navigator.pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
      }
    } on UnauthorizedException {
      if (!context.mounted) return;
      await _handleUnauthorized(context);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      if (context.mounted) {
        _showError(context, _resolveErrorMessage(e, localizations));
      }
    }
  }

  Future<void> forgotPassword(BuildContext context, String email) async {
    final localizations = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);

    state = const AsyncLoading();

    try {
      await _forgotPasswordUseCase(email);
      state = AsyncData(await build());

      if (context.mounted) {
        messenger.showSnackBar(
          SnackBar(content: Text(localizations.forgotPasswordSuccess)),
        );
      }
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      if (context.mounted) {
        _showError(context, _resolveErrorMessage(e, localizations));
      }
    }
  }

  Future<User?> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('user');
    if (jsonString == null) return null;
    return User.fromJson(jsonDecode(jsonString));
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.red),
    );
  }

  String _resolveErrorMessage(Object e, AppLocalizations localizations) {
    if (e is HttpException) return e.message;
    if (e is AuthException) return e.message;
    if (e is NoInternetException) return e.message;
    if (e is UnauthorizedException) return e.message;
    return localizations.unknownError;
  }

  Future<void> _handleUnauthorized(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (!context.mounted) return;
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
  }
}
