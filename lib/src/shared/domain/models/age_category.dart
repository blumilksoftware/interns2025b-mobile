import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';

enum AgeCategory {
  everyone,
  adults,
  youth,
  children;

  String localized(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    switch (this) {
      case AgeCategory.everyone:
        return localization.ageEveryone;
      case AgeCategory.adults:
        return localization.ageAdults;
      case AgeCategory.youth:
        return localization.ageTeens;
      case AgeCategory.children:
        return localization.ageKids;
    }
  }

  static AgeCategory fromString(String? value) {
    return AgeCategory.values.firstWhere(
      (e) => e.name.toLowerCase() == value?.toLowerCase(),
      orElse: () => AgeCategory.everyone,
    );
  }
}
