import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/custom_text_field.dart';
// import 'package:interns2025b_mobile/src/features/profile/presentation/providers/profile_controller_provider.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/labeled_text.dart';

class ProfileForm extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  const ProfileForm({
    super.key,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
  });

  @override
  ConsumerState<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends ConsumerState<ProfileForm> {

  @override
  Widget build(BuildContext context) {
    // final profileController = ref.read(profileControllerProvider.notifier);
    final localizations = AppLocalizations.of(context)!;

    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LabeledText(localizations.firstNameLabel),
          const SizedBox(height: 8),
          CustomTextField(
            controller: widget.firstNameController,
            keyboardType: TextInputType.name,
            hintText: localizations.firstNameLabel,
            validator: (value) => value == null || value.isEmpty
                ? localizations.nameRequiredError
                : null,
          ),
          const SizedBox(height: 20),

          LabeledText(localizations.lastNameLabel),
          const SizedBox(height: 8),
          CustomTextField(
            controller: widget.lastNameController,
            keyboardType: TextInputType.name,
            hintText: localizations.lastNameLabel,
          ),
        ],
      ),
    );
  }
}
