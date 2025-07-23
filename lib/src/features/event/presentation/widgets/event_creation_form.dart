import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/core/routes/app_routes.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/providers/auth_controller_provider.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/widgets/password_field.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/button.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/custom_text_field.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/labeled_text.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/language_switch_button.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/terms_of_use_text.dart';

class EventCreationForm extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController title;
  final TextEditingController description;
  final TextEditingController startTime;
  final TextEditingController endTime;
  final TextEditingController location;
  final TextEditingController? address;
  final TextEditingController? latitude;
  final TextEditingController? longitude;
  final TextEditingController imageUrl;
  final TextEditingController status;
  final TextEditingController ageCategory;

  const EventCreationForm({
    super.key,
    required this.formKey,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.imageUrl,
    required this.status,
    required this.ageCategory,
  });

  @override
  ConsumerState<EventCreationForm> createState() => _EventCreationFormState();
}

class _EventCreationFormState extends ConsumerState<EventCreationForm> {

  @override
  Widget build(BuildContext context) {
    final authController = ref.read(authControllerProvider.notifier);
    final localizations = AppLocalizations.of(context)!;

    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LabeledText(localizations.emailLabel),
          const SizedBox(height: 8),
          CustomTextField(
            controller: widget.title,
            keyboardType: TextInputType.emailAddress,
            hintText: 'example@gmail.com',
            validator: (value) => value == null || value.isEmpty
                ? localizations.emailRequiredError
                : null,
          ),
          const SizedBox(height: 20),

          LabeledText(localizations.firstNameLabel),
          const SizedBox(height: 8),
          CustomTextField(
            controller: widget.description,
            hintText: 'John',
            validator: (value) => value == null || value.isEmpty
                ? localizations.nameRequiredError
                : null,
          ),
          const SizedBox(height: 20),

          LabeledText(localizations.lastNameLabel),
          const SizedBox(height: 8),
          CustomTextField(
            controller: widget.startTime,
            hintText: 'Smith',
          ),
          const SizedBox(height: 20),

          const SizedBox(height: 24),
          Button(
            label: localizations.registerButton,
            isLoading: ref.watch(authControllerProvider).isLoading,
            fullWidth: true,
            onPressed: () {
              if (widget.formKey.currentState!.validate()) {
                authController.register(
                  context,
                  widget.title.text,
                  widget.description.text,
                  widget.startTime.text,
                  widget.endTime.text,
                  widget.location.text,
                  widget.address?.text,
                  widget.latitude?.text,
                  widget.longitude?.text,
                  widget.imageUrl.text,
                  widget.status.text,
                  widget.ageCategory.text,

                );
              }
            },
          ),

          const SizedBox(height: 24),
          const TermsOfUseText(),

          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.login);
            },
            child: Text(
              localizations.alreadyHaveAccount,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: SizedBox(
              width: double.infinity,
              child: const LanguageSwitchButton(),
            ),
          ),
        ],
      ),
    );
  }
}
