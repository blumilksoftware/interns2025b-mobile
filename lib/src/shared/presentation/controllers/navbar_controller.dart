import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/navbar_pages.dart';

class NavbarController extends Notifier<NavbarPages> {
  @override
  NavbarPages build() => NavbarPages.home;

  void navigateTo(NavbarPages page, BuildContext context) {
    if (state == page) return;

    state = page;
    Navigator.pushReplacementNamed(context, page.routeName);
  }
}
