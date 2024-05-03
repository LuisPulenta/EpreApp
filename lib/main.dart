import 'dart:convert';

import 'package:epreapp/models/models.dart';
import 'package:epreapp/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:epreapp/screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

//--------------------------------------------------------------------------
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

//--------------------------------------------------------------------------
class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  bool _showLoginPage = true;

  //--------------------------- initState ----------------------------------
  @override
  void initState() {
    super.initState();
    _getHome();
  }

//--------------------------- Pantalla ----------------------------------
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cascaron App',
      theme: AppTheme.lightTheme,
      home: _isLoading ? const WaitScreen() : const HomeScreen(),
    );
  }

//--------------------------- SharedPreferences -----------------------
  void _getHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isRemembered = prefs.getBool('isRemembered') ?? false;

    if (isRemembered) {
      String? userBody = prefs.getString('userBody');
      String date = prefs.getString('date').toString();
      String dateAlmacenada = date.substring(0, 10);
      String dateActual = DateTime.now().toString().substring(0, 10);
      if (userBody != null) {
        var decodedJson = jsonDecode(userBody);
        if (dateAlmacenada != dateActual) {
          _showLoginPage = true;
        } else {
          _showLoginPage = false;
        }
      }
    }

    _isLoading = false;
    setState(() {});
  }
}
