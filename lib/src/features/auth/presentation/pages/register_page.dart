import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/core/routes/app_routes.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/widgets/app_header.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/widgets/register_form.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppHeader(
            title: localizations.registerTitle,
            subtitleText: localizations.alreadyHaveAccount,
            linkText: localizations.loginTitle,
            onRegisterTap: () {
              Navigator.pushNamed(context, AppRoutes.login);
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: RegisterForm(
                formKey: formKey,
                emailController: emailController,
                firstNameController: firstNameController,
                lastNameController: lastNameController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
