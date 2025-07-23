import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/custom_text_field.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/labeled_text.dart';

class LocationSection extends StatelessWidget {
  final TextEditingController location;
  final TextEditingController address;

  const LocationSection({
    super.key,
    required this.location,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabeledText(localizations.locationLabel),
        const SizedBox(height: 8),
        CustomTextField(
          controller: location,
          hintText: localizations.locationHint,
        ),
        const SizedBox(height: 20),

        LabeledText(localizations.addressLabel),
        const SizedBox(height: 8),
        CustomTextField(
          controller: address,
          hintText: localizations.addressHint,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
