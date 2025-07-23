import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';

enum AgeCategory { everyone, adults, youth, children }

extension AgeCategoryX on AgeCategory {
  String label(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (this) {
      case AgeCategory.everyone:
        return localizations.ageEveryone;
      case AgeCategory.adults:
        return localizations.ageAdults;
      case AgeCategory.youth:
        return localizations.ageTeens;
      case AgeCategory.children:
        return localizations.ageKids;
    }
  }

  static AgeCategory? fromLabel(BuildContext context, String label) {
    return AgeCategory.values.firstWhere(
      (e) => e.label(context) == label,
      orElse: () => AgeCategory.everyone,
    );
  }
}
