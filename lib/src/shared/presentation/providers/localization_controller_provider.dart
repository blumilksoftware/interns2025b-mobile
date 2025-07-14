import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/shared/presentation/controllers/localization_controller.dart';

final localizationControllerProvider =
    ChangeNotifierProvider<LocalizationController>((ref) {
      return LocalizationController();
    });
