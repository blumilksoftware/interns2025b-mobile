import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/core/constants/app_constants.dart';
import 'package:interns2025b_mobile/src/core/presentation/auth_wrapper.dart';
import 'package:interns2025b_mobile/src/core/routes/app_routes.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/pages/login_page.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/pages/register_page.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/pages/profile_page.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/providers/profile_user_provider.dart';
import 'package:interns2025b_mobile/src/shared/presentation/providers/localization_controller_provider.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_theme.dart';

class AppInitializer extends ConsumerWidget {
  const AppInitializer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localizationControllerProvider).locale;
    final user = ref.watch(profileUserProvider);

    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.light,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('pl')],
      home: AuthWrapper(user: user),
      routes: {
        AppRoutes.register: (context) => const RegisterPage(),
        AppRoutes.login: (context) => const LoginPage(),
        AppRoutes.forgotPassword: (context) => const ForgotPasswordPage(),
        AppRoutes.profile: (context) => const ProfilePage(),
        AppRoutes.addEvent: (context) => Placeholder(),
        AppRoutes.home: (context) => Placeholder(),
      },
    );
  }
}
