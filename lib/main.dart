import 'package:flutter/material.dart';

import 'home_page.dart';

void main() => runApp(DemoApp());

class DemoApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
          textTheme: TextTheme(
              body1: TextStyle(color: Colors.black),
              display1: TextStyle(color: Colors.grey[600])
          )
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}