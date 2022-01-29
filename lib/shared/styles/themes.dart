import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

ThemeData themeLight = ThemeData(
  fontFamily: 'Cairo',
  backgroundColor: Colors.white,
  primaryColor: const Color(0xFF079992),
  cursorColor: primaryColor,
  dialogBackgroundColor: Colors.white,
  colorScheme: const ColorScheme.light(primary: primaryColor),
  buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
  highlightColor: Colors.white,
  textSelectionColor: primaryColor,
  splashColor: primaryColor,
  timePickerTheme: const TimePickerThemeData(
    dialBackgroundColor: Colors.white,
    dayPeriodBorderSide: BorderSide(color: Colors.white),
    hourMinuteTextStyle: TextStyle(fontSize: 28.0, color: Colors.black54),
    entryModeIconColor: primaryColor,
    helpTextStyle: TextStyle(color: primaryColor),
    inputDecorationTheme: InputDecorationTheme(
      hoverColor: primaryColor,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    hoverColor: primaryColor,
    focusColor: primaryColor,
    enabledBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    prefixStyle: TextStyle(
      color: primaryColor,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0.0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: primaryColor,
      selectedIconTheme: IconThemeData()),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
        textStyle:
            MaterialStateProperty.all(const TextStyle(color: primaryColor))),
  ),
  focusColor: primaryColor,
  scaffoldBackgroundColor: backgroundColor,
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    titleTextStyle: TextStyle(fontSize: 16.0),
    backgroundColor: primaryColor,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    elevation: 8.0,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        fontSize: 12.0, color: Colors.black54, fontWeight: FontWeight.bold),
    subtitle1: TextStyle(fontSize: 12.0),
    subtitle2: TextStyle(fontSize: 14.0, color: detColor),
    headline5: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color: Colors.black87),
    headline6: TextStyle(
        fontSize: 12.5, color: Color(0xff2f2c2c), fontWeight: FontWeight.bold),
    headline1: TextStyle(
        fontSize: 14.5, color: Color(0xffffffff), fontWeight: FontWeight.bold),
    headline4: TextStyle(
        fontSize: 15, color: Color(0xffffffff), fontWeight: FontWeight.bold),
    bodyText2: TextStyle(
        fontSize: 14.0, color: backgroundColor, fontWeight: FontWeight.bold),
    headline2: TextStyle(
        decoration: TextDecoration.lineThrough,
        fontSize: 14.0,
        color: titleColor,
        fontWeight: FontWeight.bold),
    headline3: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
  ),
  iconTheme: const IconThemeData(
    color: primaryColor,
  ),
);

ThemeData themeDark = ThemeData(
  fontFamily: 'Cairo',
  primaryColor: const Color(0xFF212121),
  splashColor: primaryColorDark,
  inputDecorationTheme: const InputDecorationTheme(
    hoverColor: primaryColorDark,
    focusColor: primaryColorDark,
    enabledBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    prefixStyle: TextStyle(
      color: primaryColorDark,
    ),
  ),
  backgroundColor: primaryColorDark,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: primaryColorDark,
      elevation: 0.0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.white10,
      selectedIconTheme: IconThemeData()),
  toggleableActiveColor: seconderColorDark,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
        textStyle:
            MaterialStateProperty.all(const TextStyle(color: Colors.white))),
  ),
  cardTheme: const CardTheme(
    color: CardDark,
  ),
  focusColor: primaryColorDark,
  scaffoldBackgroundColor: seconderColorDark,
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    titleTextStyle: TextStyle(fontSize: 16.0),
    backgroundColor: primaryColorDark,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: primaryColorDark,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primaryColorDark,
    elevation: 8.0,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.bold),
    subtitle1: TextStyle(fontSize: 12.0,color: Colors.white),
    subtitle2: TextStyle(fontSize: 14.0, color: Colors.white),
    headline5: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color: Colors.white),
    headline6: TextStyle(
        fontSize: 12.5, color: Colors.white, fontWeight: FontWeight.bold),
    headline1: TextStyle(
        fontSize: 14.5, color: Colors.white, fontWeight: FontWeight.bold),
    headline4: TextStyle(
        fontSize: 15, color:Colors.white, fontWeight: FontWeight.bold),
    bodyText2: TextStyle(
        fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold),
    headline2: TextStyle(
        decoration: TextDecoration.lineThrough,
        fontSize: 14.0,
        color: Colors.white,
        fontWeight: FontWeight.bold),
    headline3: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold,color: Colors.white),
  ),
  iconTheme: const IconThemeData(
    color: primaryColor,
  ),
  cursorColor: primaryColor,
  dialogBackgroundColor: Colors.white,
  colorScheme: ColorScheme.light(primary: primaryColor),
  buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
  highlightColor: Colors.white,
  textSelectionColor: primaryColor,
  timePickerTheme: const TimePickerThemeData(
    dialBackgroundColor: Colors.white,
    dayPeriodBorderSide: BorderSide(color: Colors.white),
    hourMinuteTextStyle: TextStyle(fontSize: 28.0, color: Colors.black54),
    entryModeIconColor: primaryColor,
    helpTextStyle: TextStyle(color: primaryColor),
    inputDecorationTheme: InputDecorationTheme(
      hoverColor: primaryColor,
    ),
  ),
);
