import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/navbar_pages.dart';
import 'package:interns2025b_mobile/src/shared/presentation/controllers/navbar_controller.dart';

final navbarControllerProvider =
    NotifierProvider<NavbarController, NavbarPages>(() => NavbarController());
