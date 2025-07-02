import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:flutter/services.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onRegisterTap;

  const AppHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.onRegisterTap,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF025F60),
        statusBarIconBrightness: Brightness.light,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 70),
        width: double.infinity,
        decoration: const BoxDecoration(color: Color(0xFF025F60)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/app_logo.png',
              height: 48,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 40),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: onRegisterTap,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: localizations.noAccount,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    TextSpan(
                      text: " ${localizations.registerTitle}",
                      style: const TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
