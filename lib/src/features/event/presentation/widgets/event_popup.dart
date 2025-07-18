import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/event_model.dart';

class EventPopup extends StatelessWidget {
  final Event event;

  const EventPopup({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Card(
      margin: const EdgeInsets.only(top: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: 250,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              if (event.location != null)
                Text(event.location!, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                  },
                  child: Text(localizations.seeDetails),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
