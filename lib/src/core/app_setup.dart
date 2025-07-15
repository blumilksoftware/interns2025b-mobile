import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/core/presentation/app_initializer.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/providers/auth_controller_provider.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/providers/profile_controller_provider.dart';
import 'package:interns2025b_mobile/src/shared/presentation/providers/localization_loader_provider.dart';

class AppSetup {
  static Future<ProviderScopeApp> initialize() async {
    await dotenv.load(fileName: '.env');

    final container = ProviderContainer();
    await container.read(localizationLoaderProvider.future);

    final authController = container.read(authControllerProvider.notifier);
    await authController.build();

    final profileController = container.read(
      profileControllerProvider.notifier,
    );
    await profileController.fetchUserProfile();

    return ProviderScopeApp(
      container: container,
      overrides: [],
      child: const AppInitializer(),
    );
  }
}

class ProviderScopeApp {
  final ProviderContainer container;
  final List<Override> overrides;
  final Widget child;

  ProviderScopeApp({
    required this.container,
    required this.overrides,
    required this.child,
  });
}
