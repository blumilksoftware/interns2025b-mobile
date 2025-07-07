import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final String subtitleText;
  final String linkText;
  final VoidCallback? onRegisterTap;

  const AppHeader({
    super.key,
    required this.title,
    required this.subtitleText,
    required this.linkText,
    this.onRegisterTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 70),
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.background),
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
                color: AppColors.textLight,
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
                      text: '$subtitleText ',
                      style: const TextStyle(
                        color: AppColors.textLightSecondary,
                      ),
                    ),
                    TextSpan(
                      text: linkText,
                      style: const TextStyle(
                        color: AppColors.textLight,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.textLight,
                        decorationThickness: 2,
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
