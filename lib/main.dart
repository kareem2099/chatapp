import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/localization/app_localization.dart';
import 'package:chatapp/screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLocalizations>(
      create: (_) => AppLocalizations(const Locale('en', 'US')),
      child: Builder(
        builder: (context) {
          final appLocalizations = Provider.of<AppLocalizations>(context);
          return MaterialApp(
            supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
            localizationsDelegates: const [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            locale:
                appLocalizations.local, // Use local getter instead of _locale
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: SplashScreen(),
            ),
          );
        },
      ),
    );
  }
}
