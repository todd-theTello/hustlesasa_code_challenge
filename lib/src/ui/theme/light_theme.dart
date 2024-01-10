import 'package:flutter/material.dart';
import 'package:hustlesasa_code_challenge/utils/color.dart';

import 'text_styles.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: const Color(0xFF00CC99),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFFF7F7F7),
    centerTitle: true,
    titleTextStyle: kAppBarHeader,
    surfaceTintColor: Colors.transparent,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: kPrimaryColor,
    extendedSizeConstraints: const BoxConstraints(maxHeight: 88),
    foregroundColor: Colors.white,
  ),
  tabBarTheme: TabBarTheme(
    splashFactory: NoSplash.splashFactory,
    labelColor: kPrimaryColor,
    overlayColor: MaterialStatePropertyAll(kPrimaryColor.withOpacity(0.3)),
    indicatorSize: TabBarIndicatorSize.tab,
    labelPadding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
    labelStyle: kLabelStyle.copyWith(fontWeight: FontWeight.w500),
    unselectedLabelStyle: kLabelStyle.copyWith(fontWeight: FontWeight.w500),
    unselectedLabelColor: const Color(0xFF626266),
    indicatorColor: kPrimaryColor,
  ),
  scaffoldBackgroundColor: Colors.white,
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: kPrimaryColor,
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        fontFamily: 'GT Walsheim Pro',
        fontWeight: FontWeight.w500,
        height: 0,
      ),
    ),
  ),
  useMaterial3: true,
);
