import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/src/core/routes/app_routes.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/widgets/app_header.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/widgets/forgot_password_form.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        children: [
          AppHeader(
            title: localizations.forgotPasswordTitle,
            subtitleText: localizations.rememberPassword,
            linkText: localizations.loginTitle,
            onRegisterTap: () {
              Navigator.pushNamed(context, AppRoutes.login);
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ForgotPasswordForm(
                formKey: formKey,
                emailController: emailController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
