import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color.fromARGB(255, 107, 128, 155);
  static const Color secondary = Color.fromARGB(255, 153, 164, 187);

//----------------------------- lightTheme -----------------------------

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    //Color primario
    primaryColor: primary,

    //AppBar Theme
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0,
      centerTitle: true,
    ),

    //TextButtonTheme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primary),
    ),

    //FloatingActionButton
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    //ElevatedButtons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        shape: const StadiumBorder(),
        elevation: 0,
        //minimumSize: Size(170, 50),
      ),
    ),
  );
}
