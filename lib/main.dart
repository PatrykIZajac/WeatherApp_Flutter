import 'package:first_app/database/db.dart';
import 'package:first_app/local_storage/user_preferences.dart';
import 'package:first_app/providers/favorite_provider.dart';
import 'package:first_app/providers/theme_provider.dart';
import 'package:first_app/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'Screens/home_page.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Db().init();
  await UserPreferences().init();

  runApp(MultiProvider(
    providers: [
      ListenableProvider<WeatherProvider>(create: (_) => WeatherProvider()),
      ListenableProvider<FavoriteProvider>(create: (_) => FavoriteProvider()),
      ListenableProvider<ThemeProvider>(create: (_) => ThemeProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFfca311),
    primaryColor: Colors.black,
    textTheme:
        TextTheme(headline1: TextStyle(fontSize: 20, color: Colors.black)),
  );

  ThemeData _darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFF1E1E20),
    brightness: Brightness.dark,
    primaryColor: Colors.greenAccent[400],
    textTheme:
        TextTheme(headline1: TextStyle(fontSize: 20, color: Colors.white)),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: context.watch<ThemeProvider>().dark ? _darkTheme : _lightTheme,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: Locale(UserPreferences().getLang()),
      home: MyHomePage(),
    );
  }
}
