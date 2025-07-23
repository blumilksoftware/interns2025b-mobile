import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/age_category.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/labeled_text.dart';

class AgeCategoryDropdown extends StatelessWidget {
  final AgeCategory? selected;
  final ValueChanged<AgeCategory?> onChanged;

  const AgeCategoryDropdown({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabeledText(localizations.ageCategoryLabel),
        const SizedBox(height: 8),
        DropdownButtonFormField<AgeCategory>(
          value: selected,
          items: AgeCategory.values.map((category) {
            return DropdownMenuItem(
              value: category,
              child: Text(category.label(context)),
            );
          }).toList(),
          onChanged: onChanged,
          validator: (value) =>
              value == null ? localizations.ageCategoryHint : null,
        ),
      ],
    );
  }
}
