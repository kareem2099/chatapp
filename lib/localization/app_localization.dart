import 'package:flutter/material.dart';

class AppLocalizations extends ChangeNotifier {
  Locale _locale;

  AppLocalizations(this._locale);

  Locale get local => _locale; // Changed from _locale to local

  static const supportedLocales = [
    Locale('en', 'US'),
    Locale('ar', 'EG'),
  ];

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'welcome': 'Welcome',
      'username': 'Username',
      'password': 'Password',
      'login': 'LogIn',
      'dont_have_account': "Don't have an account?",
      'signup': 'Signup',
    },
    'ar': {
      'welcome': 'مرحبا',
      'username': 'اسم المستخدم',
      'password': 'كلمة المرور',
      'login': 'تسجيل الدخول',
      'dont_have_account': 'ليس لديك حساب؟',
      'signup': 'سجل',
    },
  };

  String? translate(String key) {
    return _localizedValues[local.languageCode]
        ?[key]; // Changed from _locale to local
  }

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static void load(Locale newLocale) {
    _localizedValues = {
      'en': {
        'welcome': 'Welcome',
        'username': 'Username',
        'password': 'Password',
        'login': 'LogIn',
        'dont_have_account': "Don't have an account?",
        'signup': 'Signup',
      },
      'ar': {
        'welcome': 'مرحبا',
        'username': 'اسم المستخدم',
        'password': 'كلمة المرور',
        'login': 'تسجيل الدخول',
        'dont_have_account': 'ليس لديك حساب؟',
        'signup': 'سجل',
      },
    };
  }

  void updateLocale(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
