import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/shared/presentation/providers/localization_controller_provider.dart';

class LanguageSwitchButton extends ConsumerWidget {
  const LanguageSwitchButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(localizationControllerProvider);
    final notifier = ref.read(localizationControllerProvider);

    final currentLang = controller.locale.languageCode;
    final isPolish = currentLang == 'pl';
    final label = isPolish ? 'PL' : 'EN';

    return OutlinedButton.icon(
      onPressed: () {
        final newLang = isPolish ? 'en' : 'pl';
        notifier.setLocale(newLang);
      },
      icon: const Icon(Icons.language, color: Colors.black),
      label: Text(label, style: const TextStyle(color: Colors.black)),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.black, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        foregroundColor: Colors.black,
      ).copyWith(overlayColor: WidgetStateProperty.all(Colors.black12)),
    );
  }
}
