import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/navbar_pages.dart';

class NavbarController extends Notifier<NavbarPages> {
  @override
  NavbarPages build() => NavbarPages.events;

  void syncWithCurrentRoute(BuildContext context) {
    final routeName = ModalRoute.of(context)?.settings.name;
    if (routeName == null) return;

    final currentPage = NavbarPages.values.firstWhere(
      (p) => p.routeName == routeName,
      orElse: () => NavbarPages.events,
    );

    if (state != currentPage) {
      state = currentPage;
    }
  }

  void navigateTo(NavbarPages page, BuildContext context) {
    if (state == page) return;

    state = page;
    Navigator.pushReplacementNamed(context, page.routeName);
  }
}
