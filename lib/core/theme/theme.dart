/**
 * Created by Abdullah on 20/8/24.
 */

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    textTheme: TextTheme(
      //headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      //bodyText1: TextStyle(fontSize: 16),
    ),
    // Define more customizations
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blueGrey,
    // Define more customizations
  );
}
