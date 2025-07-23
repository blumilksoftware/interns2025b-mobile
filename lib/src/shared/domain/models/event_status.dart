import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';

enum EventStatus { draft, published, ongoing, ended, canceled }

extension EventStatusX on EventStatus {
  String label(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (this) {
      case EventStatus.draft:
        return localizations.statusDraft;
      case EventStatus.published:
        return localizations.statusPublished;
      case EventStatus.ongoing:
        return localizations.statusOngoing;
      case EventStatus.ended:
        return localizations.statusEnded;
      case EventStatus.canceled:
        return localizations.statusCanceled;
    }
  }

  static EventStatus fromString(String? value) {
    return EventStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => throw ArgumentError('Unknown event status: $value'),
    );
  }
}
