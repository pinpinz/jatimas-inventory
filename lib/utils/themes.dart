import 'package:flutter/material.dart';

final ThemeData themeApp = ThemeData(
  primarySwatch: Colors.blue,
  colorScheme:
      ThemeData().colorScheme.copyWith(primary: const Color(0xFF55C9E9)),
  scaffoldBackgroundColor: Colors.white,
  inputDecorationTheme: const InputDecorationTheme(
    contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 25, right: 25),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFC62828)),
      borderRadius: BorderRadius.all(Radius.circular(25)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF55C9E9)),
      borderRadius: BorderRadius.all(Radius.circular(25)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFC62828)),
      borderRadius: BorderRadius.all(Radius.circular(25)),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFBDBDBD)),
      borderRadius: BorderRadius.all(Radius.circular(25)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFBDBDBD)),
      borderRadius: BorderRadius.all(Radius.circular(25)),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFBDBDBD)),
      borderRadius: BorderRadius.all(Radius.circular(25)),
    ),
  ),
);
