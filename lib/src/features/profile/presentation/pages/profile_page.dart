import 'package:flutter/material.dart';
import 'package:interns2025b_mobile/l10n/generated/app_localizations.dart';
import 'package:interns2025b_mobile/src/core/routes/app_routes.dart';
import 'package:interns2025b_mobile/src/features/auth/presentation/widgets/app_header.dart';
import 'package:interns2025b_mobile/src/features/profile/presentation/widgets/profile_form.dart';
import 'package:interns2025b_mobile/src/shared/presentation/theme/app_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
     final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Column(
        children: [
          // AppHeader(
          //   title: localizations.registerTitle,
          //   subtitleText: localizations.alreadyHaveAccount,
          //   linkText: localizations.loginTitle,
          //   onRegisterTap: () {
          //     Navigator.pushNamed(context, AppRoutes.login);
          //   },
          // ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ProfileForm(
                formKey: formKey,
                firstNameController: firstNameController,
                lastNameController: lastNameController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
