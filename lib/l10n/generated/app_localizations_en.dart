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
  String get lastNameLabel => 'Last name (optional)';

  @override
  String get passwordLabel => 'Password';

  @override
  String get confirmPasswordLabel => 'Confirm password';

  @override
  String get registerButton => 'Register';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

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
  String get resetPassword => 'Reset password';

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
  String get tryAgainButton => 'Try again';

  @override
  String get noLoggedUser => 'No logged user';

  @override
  String get userName => 'User name';

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

  @override
  String get registerSuccess => 'Registration was successful';

  @override
  String get termsTextPart => 'By registering, you agree to the ';

  @override
  String get termsTextTos => 'Terms of Service';

  @override
  String get termsTextAnd => ' and ';

  @override
  String get termsTextDpa => 'Data Processing Agreement';

  @override
  String get forgotPasswordTitle => 'Forgot password';

  @override
  String get rememberPassword => 'Do you remember password?';

  @override
  String get send => 'Send';

  @override
  String get forgotPasswordSuccess =>
      'Password reset link has been sent to your email.';

  @override
  String get or => 'or';

  @override
  String get profileUpdateNoFields => 'No fields to update';

  @override
  String get profileUpdateSuccess => 'Profile updated successfully';

  @override
  String get profileUpdateError => 'Error updating profile';
}
