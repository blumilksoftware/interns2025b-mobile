import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/core/routes/app_routes.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/widgets/app_header.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/widgets/login_form.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/language_switch_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        children: [
          AppHeader(
            title: localizations.loginTitle,
            subtitleText: localizations.noAccount,
            linkText: localizations.registerTitle,
            onRegisterTap: () {
              Navigator.pushNamed(context, AppRoutes.register);
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: LoginForm(
                formKey: formKey,
                emailController: emailController,
                passwordController: passwordController,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: SizedBox(
              width: double.infinity,
              child: LanguageSwitchButton(),
            ),
          ),
        ],
      ),
    );
  }
}
