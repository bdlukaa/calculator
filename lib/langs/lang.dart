import 'package:calculator/widget/gender_switcher.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'lang_en.dart';
import 'lang_pt.dart';

abstract class Language {
  static List<Language> get languages => [
        English(),
        Portuguese(),
      ];

  static Language of(BuildContext context) {
    Language lang;
    String locale = preferences.getString('language') ??
        Localizations.localeOf(context).languageCode;
    switch (locale) {
      case 'pt':
        lang = Portuguese();
        break;
      case 'en':
        lang = English();
        break;
      default:
        lang = English();
    }
    return lang;
  }

  static Future<void> set(BuildContext context, Language code) async {
    await preferences.setString('language', code.code);
    appBuilderKey.currentState.update();
  }

  String get code;
  String get name;

  String get calculator;

  String get basic;

  String get bmi;
  String get male;
  String get female;
  String get calculate;
  String kg(double kg);
  String cm(double cm);
  String yrs(int years);
  String get height;
  String get weight;
  String get age;
  String get yourBMI;
  String yourBmi(String bmi);
  String bmiHeight(String height);
  String bmiWeight(String weight);
  String bmiAge(int age);
  String gender(Gender gender);
  String get result;
  String lessThan(num number);
  String moreThan(num number);
  String between(num number, num number2);
  String get lowWeight;
  String get normalWeight;
  String get overWeight;
  String obesity([int grau]);
  String to(num number, num number2);
  String moreThanTo(num number, num number2);

  String get settings;
  String get user;
  String get app;
  String get theme;
  String get language;

  String get light;
  String get dark;
  String get system;

  String get closeParenthesis;

  String get zero;
  String get one;
  String get two;
  String get three;
  String get four;
  String get five;
  String get six;
  String get seven;
  String get eight;
  String get nine;
  String get point;
  String get equal;

  String get clear;
  String get deleteLast;
  String get division;
  String get times;
  String get minus;
  String get plus;

  String get sin;
  String get cos;
  String get tan;
  String get openParenthesis;
  String get closeParenthesisTooltip;
  String get pi;
  String get squareRoot;
  String get percentage;
  String get e;
  String get exponecial;
  String get factorial;
  String get logarithm;

  String get sine;
  String get tangent;
  String get cosine;

  String get mismatchedParenthesis;
  String get invalidNumber;
  String get incompleteExpression;

  String exception(int exception) {
    String exe;
    switch (exception) {
      case 1: exe = this.mismatchedParenthesis; break;
      case 2: exe = this.invalidNumber; break;
      case 3: exe = this.incompleteExpression; break;
      default: exe = '';
    }
    return exe;
  }

  String get history;
  String get noHistory;
  String get currentExpression;
  String get today;
  String get yesterday;

  String get authKeyError;
  String get swapCurrencies;
  String get convert;
  String get currenciesConverter;

  String get checkConnection;

}
