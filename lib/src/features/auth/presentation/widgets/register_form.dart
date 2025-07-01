import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/custom_text_field.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/button.dart';
import 'package:interns2025b_mobile/src/core/routes/app_routes.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
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
          Text(
            localizations.emailLabel,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
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
          Text(
            localizations.firstNameLabel,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            controller: widget.firstNameController,
            hintText: 'John',
            validator: (value) => value == null || value.isEmpty
                ? localizations.nameRequiredError
                : null,
          ),

          const SizedBox(height: 20),
          Text(
            localizations.lastNameLabel,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            controller: widget.lastNameController,
            hintText: 'Smith',
          ),

          const SizedBox(height: 20),
          Text(
            localizations.passwordLabel,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            controller: widget.passwordController,
            obscureText: !isPasswordVisible,
            hintText: '********',
            validator: (value) => value == null || value.isEmpty
                ? localizations.passwordRequiredError
                : null,
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: Colors.black54,
              ),
              onPressed: () =>
                  setState(() => isPasswordVisible = !isPasswordVisible),
            ),
          ),

          const SizedBox(height: 20),
          Text(
            localizations.confirmPasswordLabel,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            controller: widget.confirmPasswordController,
            obscureText: !isConfirmPasswordVisible,
            hintText: '********',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return localizations.passwordRequiredError;
              }
              if (value != widget.passwordController.text) {
                return localizations.passwordsDoNotMatch;
              }
              return null;
            },
            suffixIcon: IconButton(
              icon: Icon(
                isConfirmPasswordVisible
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.black54,
              ),
              onPressed: () => setState(
                () => isConfirmPasswordVisible = !isConfirmPasswordVisible,
              ),
            ),
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
          Center(
            child: Text.rich(
              TextSpan(
                text: 'Rejestrując się wyrażasz zgodę na ',
                style: const TextStyle(fontSize: 12, color: Colors.black54),
                children: [
                  TextSpan(
                    text: 'Warunki świadczenia usług',
                    style: const TextStyle(color: Color(0xFF0A8270)),
                  ),
                  const TextSpan(text: ' oraz '),
                  TextSpan(
                    text: 'Umowę o przetwarzaniu danych',
                    style: const TextStyle(color: Color(0xFF0A8270)),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),

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
