
import 'package:app_flutter/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter/form_screen.dart';
import 'package:app_flutter/pages/signin.dart';
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
        '/': (context) => FormScreen(),
        '/sign-in': (context) => SigninPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
