import 'package:Sivayogi_The_Guru/classes/language_constants.dart';
import 'package:Sivayogi_The_Guru/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'loginscreen.dart';
import 'registerpage.dart';
import 'home.dart';
import 'profilepage.dart';
import 'aboutspage.dart';
import 'bookpage.dart';
import 'imagepage.dart';
import 'courses_page.dart';
import 'donation_page.dart';

var KColorScheme = ColorScheme.fromSeed(
  seedColor: HexColor('025CAF'),
);

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
      print(_locale);
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Localization',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        'login': (context) => const LoginScreen(),
        'register': (context) => const RegisterScreen(),
        'home': (context) => const Homepage(),
        'profile': (context) => const ProfilePage(),
        'about': (context) => AboutsPage(_locale!),
        'Books': (context) => BooksPage(_locale!),
        'image': (context) => const ImagePage(),
        'cources': (context) => CoursesPage(_locale!),
        'donation': (context) => const DonationPage(),
      },
    );
  }
}
