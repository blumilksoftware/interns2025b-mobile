import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/widgets/logout_button.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/providers/profile_controller_provider.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/profile_form.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/button.dart';

class ProfileEditSection extends ConsumerStatefulWidget {
  const ProfileEditSection({super.key});

  @override
  ConsumerState<ProfileEditSection> createState() => _ProfileEditSectionState();
}

class _ProfileEditSectionState extends ConsumerState<ProfileEditSection> {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final controller = ref.read(profileControllerProvider.notifier);
      await controller.fetchUserProfile();
      final user = ref.read(profileControllerProvider).user;
      firstNameController.text = user?.firstName ?? '';
      lastNameController.text = user?.lastName ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(profileControllerProvider);
    final notifier = ref.read(profileControllerProvider.notifier);
    final localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (controller.isEditing) ...[
          ProfileForm(
            formKey: formKey,
            firstNameController: firstNameController,
            lastNameController: lastNameController,
          ),
          const SizedBox(height: 16),
          Button(
            label: localizations.saveChanges,
            fullWidth: true,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                notifier.updateProfile(
                  context: context,
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                );
              }
            },
          ),
          const SizedBox(height: 24),
        ],
        const LogoutButton(),
      ],
    );
  }
}
