import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/shared/presentation/providers/localization_controller_provider.dart';

final localizationLoaderProvider = FutureProvider<void>((ref) async {
  final controller = ref.read(localizationControllerProvider);
  await controller.loadLocale();
});
