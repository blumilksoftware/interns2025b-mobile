import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:interns2025b_mobile/src/core/routes/app_routes.dart';

import 'package:interns2025b_mobile/src/core/constants/app_constants.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/pages/register_page.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/pages/login_page.dart';
import 'package:interns2025b_mobile/src/shared/presentation/controllers/localization_controller.dart';
import 'package:provider/provider.dart';

class AppInitializer extends StatelessWidget {
  const AppInitializer({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationController = Provider.of<LocalizationController>(context);
    return MaterialApp(
      title: AppConstants.appName,
      locale: localizationController.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('pl')],
      initialRoute: AppRoutes.register,
      routes: {
        AppRoutes.register: (context) => RegisterPage(),
        AppRoutes.login: (context) => LoginPage(),
      },
    );
  }
}
