import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/event/presentation/providers/event_view_mode_provider.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ToggleViewModeSwitch extends ConsumerWidget {
  const ToggleViewModeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final currentMode = ref.watch(eventViewModeProvider);
    final notifier = ref.read(eventViewModeProvider.notifier);

    return ToggleSwitch(
      initialLabelIndex: currentMode == EventViewMode.list ? 0 : 1,
      totalSwitches: 2,
      labels: [localizations.list, localizations.map],
      onToggle: (index) {
        notifier.state = index == 0 ? EventViewMode.list : EventViewMode.map;
      },
      minWidth: 178.95,
      minHeight: 39.0,
      cornerRadius: 9.0,
      radiusStyle: true,
      activeBgColor: const [AppColors.primary],
      activeFgColor: AppColors.backgroundLight,
      inactiveBgColor: AppColors.inactiveBackground,
      inactiveFgColor: AppColors.primary,
    );
  }
}
