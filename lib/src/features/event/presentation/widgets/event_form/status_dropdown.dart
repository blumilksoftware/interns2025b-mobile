import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_status.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/labeled_text.dart';

class StatusDropdown extends StatelessWidget {
  final EventStatus? selected;
  final ValueChanged<EventStatus?> onChanged;

  const StatusDropdown({
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
        LabeledText(localizations.statusLabel),
        const SizedBox(height: 8),
        DropdownButtonFormField<EventStatus>(
          value: selected,
          items: [EventStatus.draft, EventStatus.published].map((status) {
            return DropdownMenuItem(
              value: status,
              child: Text(status.label(context)),
            );
          }).toList(),
          onChanged: onChanged,
          validator: (value) => value == null ? localizations.statusHint : null,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
