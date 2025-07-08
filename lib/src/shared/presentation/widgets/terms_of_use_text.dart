import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';

class TermsOfUseText extends StatelessWidget {
  const TermsOfUseText({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Text.rich(
      TextSpan(
        text: localizations.termsTextPart,
        style: const TextStyle(fontSize: 12, color: AppColors.secondary),
        children: [
          TextSpan(
            text: localizations.termsTextTos,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
          TextSpan(text: localizations.termsTextAnd),
          TextSpan(
            text: localizations.termsTextDpa,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
