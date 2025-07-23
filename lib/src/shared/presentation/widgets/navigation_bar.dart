import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/shared/domain/models/navbar_pages.dart';
import 'package:interns2025b_mobile/src/shared/presentation/controllers/navbar_controller.dart';
import 'package:interns2025b_mobile/src/shared/presentation/providers/navbar_controller_provider.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/labeled_text.dart';

class NavigationBarWidget extends ConsumerStatefulWidget {
  const NavigationBarWidget({super.key});

  @override
  ConsumerState<NavigationBarWidget> createState() =>
      _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends ConsumerState<NavigationBarWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(navbarControllerProvider.notifier).syncWithCurrentRoute(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedPage = ref.watch(navbarControllerProvider);
    final controller = ref.read(navbarControllerProvider.notifier);

    return Container(
      height: 70,
      color: Colors.black,
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: _buildIconButton(
                page: NavbarPages.events,
                selectedPage: selectedPage,
                onTap: () => controller.navigateTo(NavbarPages.events, context),
              ),
            ),
          ),
          SizedBox(
            width: 70,
            child: Center(child: _buildCenterAddButton(context, controller)),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: _buildIconButton(
                page: NavbarPages.profile,
                selectedPage: selectedPage,
                onTap: () => controller.navigateTo(NavbarPages.profile, context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required NavbarPages page,
    required NavbarPages selectedPage,
    required VoidCallback onTap,
  }) {
    final isSelected = page == selectedPage;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              page.icon,
              color: isSelected ? AppColors.primary : AppColors.backgroundLight,
              size: 28,
            ),
            const SizedBox(height: 4),
            LabeledText(
              page.localizedLabel(context),
              isBold: isSelected,
              fontSize: 12,
              color: isSelected ? AppColors.primary : AppColors.backgroundLight,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterAddButton(
    BuildContext context,
    NavbarController controller,
  ) {
    return GestureDetector(
      onTap: () => controller.navigateTo(NavbarPages.addEvent, context),
      child: Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.add, color: AppColors.backgroundLight),
      ),
    );
  }
}
