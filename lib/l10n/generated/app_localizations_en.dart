// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get registerTitle => 'Register';

  @override
  String get loginTitle => 'Login';

  @override
  String get emailLabel => 'Email';

  @override
  String get firstNameLabel => 'Name';

  @override
  String get lastNameLabel => 'Last name (Optional)';

  @override
  String get passwordLabel => 'Password';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get registerButton => 'Register';

  @override
  String get alreadyHaveAccount => 'Already have an account? Login';

  @override
  String get selectLanguage => 'Select language';

  @override
  String get unknownError => 'Something went wrong. Try again.';

  @override
  String get loginSuccess => 'Logged in successfully';

  @override
  String get logoutError => 'Logout failed.';

  @override
  String get restPasswordLink =>
      'Password reset link has been sent to your email.';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get forgotPasswordEmailInstruction =>
      'Enter the email address where we will send the password reset link:';

  @override
  String get emailRequiredError => 'Please enter your email';

  @override
  String get passwordRequiredError => 'Please enter your password';

  @override
  String get sendResetLinkButton => 'Send reset link';

  @override
  String get nameRequiredError => 'Please enter your name';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get logout => 'Log out';

  @override
  String get logouting => 'Logging out';

  @override
  String get logoutConfirmation => 'Are you sure you want to log out?';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirmLogout => 'Log out';

  @override
  String get tryAgainButton => 'Try Again';

  @override
  String get noLoggedUser => 'No logged user';

  @override
  String get userName => 'User Name';

  @override
  String get errorFetchingData => 'Error while fetching data.';

  @override
  String get noData => 'No data.';

  @override
  String createdAt(Object date) {
    return 'Created at: $date';
  }

  @override
  String get loginWithFacebook => 'Login with Facebook';

  @override
  String get forgotPassword => 'Forgot password?';
}
