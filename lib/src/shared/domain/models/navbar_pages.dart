import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/core/routes/app_routes.dart';

enum NavbarPages { events, addEvent, profile }

extension NavbarPagesExtension on NavbarPages {
  String get routeName {
    switch (this) {
      case NavbarPages.events:
        return AppRoutes.events;
      case NavbarPages.addEvent:
        return AppRoutes.addEvent;
      case NavbarPages.profile:
        return AppRoutes.profile;
    }
  }

  IconData get icon {
    switch (this) {
      case NavbarPages.events:
        return Icons.search;
      case NavbarPages.addEvent:
        return Icons.add;
      case NavbarPages.profile:
        return Icons.person_outline_rounded;
    }
  }

  bool get requiresAuth {
    return this == NavbarPages.addEvent;
  }

  String localizedLabel(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (this) {
      case NavbarPages.events:
        return localizations.navbarEvents;
      case NavbarPages.addEvent:
        return localizations.navbarAdd;
      case NavbarPages.profile:
        return localizations.navbarProfile;
    }
  }
}
