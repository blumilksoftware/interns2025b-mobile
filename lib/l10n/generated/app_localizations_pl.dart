// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get registerTitle => 'Zarejestruj się';

  @override
  String get loginTitle => 'Zaloguj się';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get firstNameLabel => 'Nazwa';

  @override
  String get lastNameLabel => 'Nazwisko (opcjonalne)';

  @override
  String get passwordLabel => 'Hasło';

  @override
  String get confirmPasswordLabel => 'Potwierdź hasło';

  @override
  String get registerButton => 'Zarejestruj się';

  @override
  String get alreadyHaveAccount => 'Masz już konto?';

  @override
  String get selectLanguage => 'Wybierz język';

  @override
  String get unknownError => 'Coś poszło nie tak. Spróbuj ponownie.';

  @override
  String get loginSuccess => 'Zalogowano pomyślnie';

  @override
  String get logoutError => 'Wylogowanie nie powiodło się.';

  @override
  String get restPasswordLink =>
      'Link do zmiany hasła został wysłany na Twoją skrzynkę pocztową.';

  @override
  String get resetPassword => 'Resetuj hasło';

  @override
  String get forgotPasswordEmailInstruction =>
      'Podaj e-mail, na który wyślemy link do resetu hasła:';

  @override
  String get emailRequiredError => 'Podaj e-mail';

  @override
  String get passwordRequiredError => 'Podaj hasło';

  @override
  String get sendResetLinkButton => 'Wyślij link resetujący';

  @override
  String get nameRequiredError => 'Podaj imię';

  @override
  String get passwordsDoNotMatch => 'Hasła nie są takie same';

  @override
  String get noAccount => 'Nie masz konta?';

  @override
  String get logout => 'Wyloguj się';

  @override
  String get logouting => 'Wylogowanie';

  @override
  String get logoutConfirmation => 'Czy na pewno chcesz się wylogować?';

  @override
  String get cancel => 'Anuluj';

  @override
  String get confirmLogout => 'Wyloguj';

  @override
  String get tryAgainButton => 'Spróbuj ponownie';

  @override
  String get noLoggedUser => 'Brak zalogowanego użytkownika';

  @override
  String get userName => 'Nazwa użytkownika';

  @override
  String get errorFetchingData => 'Błąd podczas pobierania danych.';

  @override
  String get noData => 'Brak danych.';

  @override
  String createdAt(Object date) {
    return 'Utworzono: $date';
  }

  @override
  String get loginWithFacebook => 'Zaloguj się za pomocą Facebook';

  @override
  String get forgotPassword => 'Nie pamiętasz hasła?';

  @override
  String get registerSuccess => 'Rejestracja przebiegła pomyślnie';

  @override
  String get termsTextPart => 'Rejestrując się wyrażasz zgodę na ';

  @override
  String get termsTextTos => 'Warunki świadczenia usług\'';

  @override
  String get termsTextAnd => ' oraz ';

  @override
  String get termsTextDpa => 'Umowę o przetwarzaniu danych';

  @override
  String get forgotPasswordTitle => 'Przypomnij hasło';

  @override
  String get rememberPassword => 'Pamiętasz hasło?';

  @override
  String get send => 'Wyślij';

  @override
  String get forgotPasswordSuccess =>
      'Link do resetu hasła został wysłany na Twoją skrzynkę pocztową.';

  @override
  String get or => 'lub';
}
