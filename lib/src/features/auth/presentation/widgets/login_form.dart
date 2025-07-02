import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/custom_text_field.dart';
import 'package:interns2025b_mobile/src/shared/presentation/widgets/button.dart';

class LoginForm extends StatefulWidget {
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
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isPasswordVisible = false;

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
            hintText: '********',
            obscureText: !isPasswordVisible,
            validator: (value) => value == null || value.isEmpty
                ? localizations.passwordRequiredError
                : null,
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: Colors.black54,
              ),
              onPressed: () {
                setState(() => isPasswordVisible = !isPasswordVisible);
              },
            ),
          ),

          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  localizations.forgotPassword,
                  style: const TextStyle(color: Color(0xFF0A8270)),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          Button(
            label: localizations.loginTitle,
            isLoading: authController.isLoading,
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
          OutlinedButton.icon(
            icon: const Icon(Icons.facebook, color: Colors.blue),
            label: Text(
              localizations.loginWithFacebook,
              style: const TextStyle(color: Colors.blue),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
