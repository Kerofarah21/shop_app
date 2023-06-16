// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  primarySwatch: defaultColor,
  appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      color: Colors.white,
      elevation: 0.0,
      titleSpacing: 20.0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      )),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 30.0,
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey,
  ),
  iconTheme: IconThemeData(
    color: Colors.black,
  ),
  fontFamily: 'Jannah',
  textTheme: TextTheme(
    headlineSmall: TextStyle(),
    headlineMedium: TextStyle(
      color: Colors.black,
    ),
    titleSmall: TextStyle(),
    titleLarge: TextStyle(),
    bodyMedium: TextStyle(),
    bodyLarge: TextStyle(),
  ).apply(
    bodyColor: Colors.black,
  ),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  primarySwatch: defaultColor,
  appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: HexColor('333739'),
      elevation: 0.0,
      titleSpacing: 20.0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      )),
  scaffoldBackgroundColor: HexColor('333739'),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 30.0,
    backgroundColor: HexColor('333739'),
    unselectedItemColor: Colors.grey,
  ),
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  fontFamily: 'Jannah',
  textTheme: TextTheme(
    headlineSmall: TextStyle(),
    headlineMedium: TextStyle(
      color: Colors.white,
    ),
    titleSmall: TextStyle(),
    titleLarge: TextStyle(),
    bodyMedium: TextStyle(),
    bodyLarge: TextStyle(),
  ).apply(
    bodyColor: Colors.white,
  ),
);
