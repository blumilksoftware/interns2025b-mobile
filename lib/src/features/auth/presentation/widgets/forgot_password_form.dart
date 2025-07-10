import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/providers/auth_controller_provider.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/button.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/custom_text_field.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/labeled_text.dart';

class ForgotPasswordForm extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;

  const ForgotPasswordForm({
    super.key,
    required this.formKey,
    required this.emailController,
  });

  @override
  ConsumerState<ForgotPasswordForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<ForgotPasswordForm> {
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
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: 'example@gmail.com',
            validator: (value) => value == null || value.isEmpty
                ? localizations.emailRequiredError
                : null,
          ),
          const SizedBox(height: 20),

          const SizedBox(height: 16),
          Button(
            label: localizations.send,
            isLoading: ref.watch(authControllerProvider).isLoading,
            fullWidth: true,
            onPressed: () {
              if (widget.formKey.currentState!.validate()) {
                authController.forgotPassword(
                  context,
                  widget.emailController.text,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
