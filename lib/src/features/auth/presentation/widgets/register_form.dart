import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:provider/provider.dart';
import 'package:interns2025b_mobile/src/core/routes/app_routes.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/button.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';

class RegisterForm extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    final localizations = AppLocalizations.of(context)!;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: localizations.emailLabel,
              labelStyle: TextStyle(color: Colors.white70),
              prefixIcon: Icon(Icons.email_outlined, color: Colors.white),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return localizations.emailRequiredError;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: firstNameController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: localizations.firstNameLabel,
              labelStyle: TextStyle(color: Colors.white70),
              prefixIcon: Icon(Icons.person_outline, color: Colors.white),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return localizations.nameRequiredError;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: lastNameController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: localizations.lastNameLabel,
              labelStyle: TextStyle(color: Colors.white70),
              prefixIcon: Icon(Icons.person_outline, color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: localizations.passwordLabel,
              labelStyle: TextStyle(color: Colors.white70),
              prefixIcon: Icon(Icons.lock_outline, color: Colors.white),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return localizations.passwordRequiredError;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: confirmPasswordController,
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: localizations.confirmPasswordLabel,
              labelStyle: TextStyle(color: Colors.white70),
              prefixIcon: Icon(Icons.lock_outline, color: Colors.white),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return localizations.passwordRequiredError;
              }
              if (value != passwordController.text) {
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
              if (formKey.currentState!.validate()) {
                authController.register(
                  context,
                  emailController.text,
                  firstNameController.text,
                  lastNameController.text,
                  passwordController.text,
                  confirmPasswordController.text,
                );
              }
            },
          ),

          const SizedBox(height: 16),

          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.login);
            },
            child: Text(
              localizations.alreadyHaveAccount,
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
