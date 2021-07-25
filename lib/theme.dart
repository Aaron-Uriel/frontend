import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData get theme => ThemeData(
    brightness: Brightness.dark,
    accentColor: Color.fromARGB(255, 186, 104, 200),
    scaffoldBackgroundColor: const Color(0x000000),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 20, 20, 20)),
        textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 60, fontWeight: FontWeight.w300)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
           (states) {
             return states.contains(MaterialState.pressed)
              ? Color.fromARGB(255, 48, 48, 48)
               : Colors.blue;
          }
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
      ),
    ),

    fontFamily: 'Roboto',

     textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 35, fontWeight: FontWeight.normal),
    ),
  );
}