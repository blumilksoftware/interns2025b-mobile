import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/button.dart';

class SubmitButtonSection extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const SubmitButtonSection({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        Button(
          label: localizations.createEventButton,
          fullWidth: true,
          onPressed: onPressed,
          isLoading: isLoading,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
