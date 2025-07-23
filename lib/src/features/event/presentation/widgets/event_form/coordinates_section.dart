import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/custom_text_field.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/labeled_text.dart';

class CoordinatesSection extends StatelessWidget {
  final TextEditingController latitude;
  final TextEditingController longitude;

  const CoordinatesSection({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabeledText(localizations.latitudeLabel),
        const SizedBox(height: 8),
        CustomTextField(
          controller: latitude,
          hintText: '51.2081',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 20),

        LabeledText(localizations.longitudeLabel),
        const SizedBox(height: 8),
        CustomTextField(
          controller: longitude,
          hintText: '16.1603',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
