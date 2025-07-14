import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/core/routes/app_routes.dart';

enum NavbarPages { home, addEvent, profile }

extension NavbarPagesExtension on NavbarPages {
  String get routeName {
    switch (this) {
      case NavbarPages.home:
        return AppRoutes.home;
      case NavbarPages.addEvent:
        return AppRoutes.addEvent;
      case NavbarPages.profile:
        return AppRoutes.profile;
    }
  }

  IconData get icon {
    switch (this) {
      case NavbarPages.home:
        return Icons.search;
      case NavbarPages.addEvent:
        return Icons.add;
      case NavbarPages.profile:
        return Icons.person;
    }
  }

  bool get requiresAuth {
    return this == NavbarPages.addEvent;
  }
}
