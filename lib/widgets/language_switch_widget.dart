import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/localization/app_localization.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.read<AppLocalizations>().local;
    final isEnglish = currentLocale.languageCode == 'en';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            final newLocale =
                isEnglish ? const Locale('ar', 'EG') : const Locale('en', 'US');
            AppLocalizations.load(newLocale); // Load new locale data
            context
                .read<AppLocalizations>()
                .updateLocale(newLocale); // Update locale
          },
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(child: child, opacity: animation);
            },
            child: Text(
              isEnglish ? 'to Arabic' : 'to English',
            ),
          ),
        ),
      ],
    );
  }
}
