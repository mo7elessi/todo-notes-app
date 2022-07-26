import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(0.0),
  borderSide: const BorderSide(width: 0.3, color: Color(0xffcbcbcb)),
);
ThemeData themeLight = ThemeData(
  fontFamily: 'PNU',
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
  inputDecorationTheme: InputDecorationTheme(
    hoverColor: primaryColor,
    focusColor: primaryColor,
    enabledBorder: outlineInputBorder,
    errorBorder: outlineInputBorder,
    focusedErrorBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    prefixStyle: TextStyle(
      color: primaryColor,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0.0,
      showSelectedLabels: true,
      showUnselectedLabels: true,
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
  cardTheme: const CardTheme(color: cardLight, elevation: 0.0),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        fontSize: 12.0, color: Colors.black54, fontWeight: FontWeight.bold),
    subtitle1: TextStyle(fontSize: 10.0),
    subtitle2: TextStyle(fontSize: 12.0),
    headline1: TextStyle(
        fontSize: 14.0, color: Color(0xffffffff), fontWeight: FontWeight.bold),
    headline2: TextStyle(
        decoration: TextDecoration.lineThrough,
        fontSize: 12.0,
        color: Colors.black54,
        fontWeight: FontWeight.bold),
    headline3: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
    headline5: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black87),
    headline6: TextStyle(
        fontSize: 12.0, color: titleColor, fontWeight: FontWeight.bold),
    headline4: TextStyle(
        fontSize: 14.0, color: Color(0xffffffff), fontWeight: FontWeight.bold),
    bodyText2: TextStyle(
        fontSize: 14.0, color: backgroundColor, fontWeight: FontWeight.bold),
  ),
  iconTheme: const IconThemeData(
    color: primaryColor,
  ),
);

ThemeData themeDark = ThemeData(
  fontFamily: 'PNU',
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
  timePickerTheme: const TimePickerThemeData(
    dialBackgroundColor: Colors.black54,
    backgroundColor: Color(0xFF262626),
    dayPeriodBorderSide: BorderSide(color: Colors.black87),
    hourMinuteTextStyle: TextStyle(fontSize: 28.0, color: Colors.white54),
    entryModeIconColor: primaryColor,
    helpTextStyle: TextStyle(color: primaryColor),
    dayPeriodTextColor: Colors.white,
    dialTextColor: Colors.white,
    hourMinuteTextColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
      hoverColor: primaryColor,
    ),
  ),
  backgroundColor: primaryColorDark,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: primaryColorDark,
      elevation: 0.0,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.white10,
      selectedIconTheme: IconThemeData()),
  toggleableActiveColor: seconderColorDark,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
        textStyle:
            MaterialStateProperty.all(const TextStyle(color: Colors.white))),
  ),
  cardTheme: const CardTheme(color: cardDark, elevation: 0.0),
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
    subtitle1: TextStyle(fontSize: 10.0, color: Colors.white),
    subtitle2: TextStyle(fontSize: 12.0, color: Colors.white),
    headline5: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
    headline6: TextStyle(
        fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.bold),
    headline1: TextStyle(
        fontSize: 14.5, color: Colors.white, fontWeight: FontWeight.bold),
    headline4: TextStyle(
        fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
    bodyText2: TextStyle(
        fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold),
    headline2: TextStyle(
        decoration: TextDecoration.lineThrough,
        fontSize: 12.0,
        color: Colors.white,
        fontWeight: FontWeight.bold),
    headline3: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
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
);
