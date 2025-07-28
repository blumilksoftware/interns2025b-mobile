import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_controller_provider.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_search_controller_provider.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';

class EventSearchBar extends ConsumerWidget {
  final String? hintText;

  const EventSearchBar({super.key, this.hintText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final controller = ref.watch(eventSearchControllerProvider);
    final eventsController = ref.read(eventsControllerProvider.notifier);

    return SizedBox(
      width: 220,
      height: 39,
      child: TextField(
        controller: controller,
        onChanged: eventsController.searchWithDebounce,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: hintText ?? localizations.eventSearchBarHint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.borderEnable),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColors.borderFocus,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: AppColors.borderFill,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}
