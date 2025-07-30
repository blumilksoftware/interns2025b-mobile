import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';

enum AgeCategory {
  everyone,
  adults,
  youth,
  children;

  String localized(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return {
      AgeCategory.everyone: localization.ageEveryone,
      AgeCategory.adults: localization.ageAdults,
      AgeCategory.youth: localization.ageTeens,
      AgeCategory.children: localization.ageKids,
    }[this]!;
  }

  static AgeCategory fromString(String? value) {
    return AgeCategory.values.firstWhere(
          (e) => e.name.toLowerCase() == value?.toLowerCase(),
      orElse: () => AgeCategory.everyone,
    );
  }
}
