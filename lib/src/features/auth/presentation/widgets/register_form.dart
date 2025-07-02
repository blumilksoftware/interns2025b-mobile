import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/widgets/password_field.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/custom_text_field.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/button.dart';
import 'package:interns2025b_mobile/src/core/routes/app_routes.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/labeled_text.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/terms_of_use_text.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const RegisterForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.firstNameController,
    required this.lastNameController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
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

          LabeledText(localizations.firstNameLabel),
          const SizedBox(height: 8),
          CustomTextField(
            controller: widget.firstNameController,
            hintText: 'John',
            validator: (value) => value == null || value.isEmpty
                ? localizations.nameRequiredError
                : null,
          ),
          const SizedBox(height: 20),

          LabeledText(localizations.lastNameLabel),
          const SizedBox(height: 8),
          CustomTextField(
            controller: widget.lastNameController,
            hintText: 'Smith',
          ),
          const SizedBox(height: 20),

          LabeledText(localizations.passwordLabel),
          const SizedBox(height: 8),
          PasswordField(
            controller: widget.passwordController,
            hintText: '********',
            isVisible: isPasswordVisible,
            toggleVisibility: () => setState(() {
              isPasswordVisible = !isPasswordVisible;
            }),
            validator: (value) => value == null || value.isEmpty
                ? localizations.passwordRequiredError
                : null,
          ),
          const SizedBox(height: 20),

          LabeledText(localizations.confirmPasswordLabel),
          const SizedBox(height: 8),
          PasswordField(
            controller: widget.confirmPasswordController,
            hintText: '********',
            isVisible: isConfirmPasswordVisible,
            toggleVisibility: () => setState(() {
              isConfirmPasswordVisible = !isConfirmPasswordVisible;
            }),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return localizations.passwordRequiredError;
              }
              if (value != widget.passwordController.text) {
                return localizations.passwordsDoNotMatch;
              }
              return null;
            },
          ),

          const SizedBox(height: 24),
          Button(
            label: localizations.registerButton,
            isLoading: authController.isLoading,
            fullWidth: true,
            onPressed: () {
              if (widget.formKey.currentState!.validate()) {
                authController.register(
                  context,
                  widget.emailController.text,
                  widget.firstNameController.text,
                  widget.lastNameController.text,
                  widget.passwordController.text,
                  widget.confirmPasswordController.text,
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
        ],
      ),
    );
  }
}
