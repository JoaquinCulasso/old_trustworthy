import 'package:flutter/material.dart';
import 'views/home_page.dart';


void main() => runApp(MyApp());

@override
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vieja Confiable',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: MyHomePage(title: 'Vieja Confiable'),
    );
  }
}


