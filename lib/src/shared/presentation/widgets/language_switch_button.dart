import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/shared/presentation/providers/localization_controller_provider.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';

class LanguageSwitchButton extends ConsumerWidget {
  const LanguageSwitchButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(localizationControllerProvider);
   
    final currentLang = controller.locale.languageCode;
    final isPolish = currentLang == 'pl';
    final label = isPolish ? 'PL' : 'EN';

    return OutlinedButton.icon(
      onPressed: () {
        final newLang = isPolish ? 'en' : 'pl';
        controller.setLocale(newLang);
      },
      icon: Icon(Icons.language, color: AppColors.black),
      label: Text(label, style:  TextStyle(color: AppColors.black)),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.black, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        foregroundColor: AppColors.black,
      ).copyWith(overlayColor: WidgetStateProperty.all(Colors.black12)),
    );
  }
}
