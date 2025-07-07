import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/providers/auth_controller_provider.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/widgets/password_field.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/labeled_text.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/custom_text_field.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/button.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';

class LoginForm extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  bool isPasswordVisible = false;

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

          LabeledText(localizations.passwordLabel),
          const SizedBox(height: 8),
          PasswordField(
            controller: widget.passwordController,
            isVisible: isPasswordVisible,
            toggleVisibility: () => setState(() {
              isPasswordVisible = !isPasswordVisible;
            }),
            validator: (value) => value == null || value.isEmpty
                ? localizations.passwordRequiredError
                : null,
          ),

          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  localizations.forgotPassword,
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          Button(
            label: localizations.loginTitle,
            isLoading: ref.watch(authControllerProvider).isLoading,
            fullWidth: true,
            onPressed: () {
              if (widget.formKey.currentState!.validate()) {
                authController.login(
                  context,
                  widget.emailController.text,
                  widget.passwordController.text,
                );
              }
            },
          ),

          const SizedBox(height: 24),
          Row(
            children: const <Widget>[
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text("lub", style: TextStyle(color: Colors.black54)),
              ),
              Expanded(child: Divider()),
            ],
          ),

          const SizedBox(height: 16),
          Button(
            label: localizations.loginWithFacebook,
            icon: Icons.facebook,
            iconColor: Colors.blue[700],
            backgroundColor: AppColors.backgroundLight,
            foregroundColor: AppColors.secondary,
            fullWidth: true,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
