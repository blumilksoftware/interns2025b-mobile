import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';

class TermsOfUseText extends StatelessWidget {
  const TermsOfUseText({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Text.rich(
      TextSpan(
        text: localizations.termsTextPart,
        style: const TextStyle(fontSize: 12, color: Colors.black54),
        children: [
          TextSpan(
            text: localizations.termsTextTos,
            style: const TextStyle(color: Color(0xFF025F60)),
          ),
          TextSpan(text: localizations.termsTextAnd),
          TextSpan(
            text: localizations.termsTextDpa,
            style: const TextStyle(color: Color(0xFF025F60)),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
