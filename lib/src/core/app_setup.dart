import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/core/presentation/app_initializer.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/providers/auth_controller_provider.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/providers/profile_controller_provider.dart';
import 'package:interns2025b_mobile/src/shared/presentation/controllers/localization_controller.dart';
import 'package:interns2025b_mobile/src/shared/presentation/providers/localization_controller_provider.dart';

class AppSetup {
  static Future<ProviderScopeApp> initialize() async {
    await dotenv.load(fileName: '.env');

    final localizationController = LocalizationController();
    await localizationController.loadLocale();

    final container = ProviderContainer();
    final authController = container.read(authControllerProvider.notifier);
    await authController.build();

    final profileController = container.read(profileControllerProvider.notifier);
    await profileController.fetchUserProfile();

    return ProviderScopeApp(
      overrides: [
        localizationControllerProvider.overrideWithValue(
          localizationController,
        ),
      ],
      child: const AppInitializer(),
    );
  }
}

class ProviderScopeApp {
  final List<Override> overrides;
  final Widget child;

  ProviderScopeApp({required this.overrides, required this.child});
}
