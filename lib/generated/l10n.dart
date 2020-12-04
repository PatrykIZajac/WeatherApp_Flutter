// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Wind`
  String get WindText {
    return Intl.message(
      'Wind',
      name: 'WindText',
      desc: '',
      args: [],
    );
  }

  /// `Pressure`
  String get PressureText {
    return Intl.message(
      'Pressure',
      name: 'PressureText',
      desc: '',
      args: [],
    );
  }

  /// `Humidity`
  String get HumidityText {
    return Intl.message(
      'Humidity',
      name: 'HumidityText',
      desc: '',
      args: [],
    );
  }

  /// `Sunset`
  String get SunsetText {
    return Intl.message(
      'Sunset',
      name: 'SunsetText',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get SearchInputText {
    return Intl.message(
      'Search',
      name: 'SearchInputText',
      desc: '',
      args: [],
    );
  }

  /// `Temperature Measure`
  String get TemperatureMeasureText {
    return Intl.message(
      'Temperature Measure',
      name: 'TemperatureMeasureText',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get LanguageText {
    return Intl.message(
      'Language',
      name: 'LanguageText',
      desc: '',
      args: [],
    );
  }

  /// `Speed unit`
  String get SpeedUnit {
    return Intl.message(
      'Speed unit',
      name: 'SpeedUnit',
      desc: '',
      args: [],
    );
  }

  /// `Choose`
  String get chooseText {
    return Intl.message(
      'Choose',
      name: 'chooseText',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkModeText {
    return Intl.message(
      'Dark Mode',
      name: 'darkModeText',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pl'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}