
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData LightTheme = ThemeData(
  primarySwatch: Colors.purple,
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Colors.black87,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),bodyText2: TextStyle(color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  fontFamily:'Baloo5',),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 50,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.purple[400],
    backgroundColor: Colors.white,
  ),
  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      backgroundColor: Colors.purple[400],
      backwardsCompatibility: false,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.w800,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.purple[400],
        statusBarIconBrightness: Brightness.light,
      ),
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.black,
        size: 15,
      )
  ),
  fontFamily: 'Baloo5',
);

ThemeData DarkTheme = ThemeData(
  primarySwatch: Colors.lightBlue,
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    bodyText2: TextStyle(color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,),
  ),
  scaffoldBackgroundColor: HexColor('333739'),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 50,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.blue[200],
    backgroundColor: HexColor('333739'),
  ),
  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      backgroundColor: HexColor('333739'),
      backwardsCompatibility: false,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w800,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      ),
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 15,
      )
  ),

);
