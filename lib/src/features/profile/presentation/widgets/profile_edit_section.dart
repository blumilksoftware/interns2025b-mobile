import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/widgets/logout_button.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/providers/profile_controller_provider.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/delete_user_request_button.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/profile_form.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/button.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/language_switch_button.dart';

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
      if (!mounted) return;
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

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
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

            const SizedBox(height: 8),
            Button(
              label: localizations.cancel,
              fullWidth: true,
              isOutlined: true,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              onPressed: notifier.toggleEdit,
            ),
          ] else ...[
            Button(
              label: localizations.editProfile,
              icon: Icons.edit,
              fullWidth: true,
              onPressed: notifier.toggleEdit,
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
            const SizedBox(height: 16),
            const LogoutButton(),
            const SizedBox(height: 16),
            const LanguageSwitchButton(),
            const Spacer(),
            const DeleteUserRequestButton(),
          ],
        ],
      ),
    );
  }
}
