
import 'package:app_flutter/pages/auth/login.dart';
import 'package:app_flutter/pages/auth/register.dart';
import 'package:app_flutter/pages/home/home.dart';
import 'package:app_flutter/pages/settings/setting.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      title: 'Mobile | App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
        '/setting': (context) => SettingsPage(),
      },
    );
  }
}
