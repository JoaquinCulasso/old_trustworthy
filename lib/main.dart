import 'package:flutter/material.dart';
import 'views/home_page.dart';

void main() => runApp(MyApp());

@override
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme(
            primary: Color.fromRGBO(137, 172, 18, 1.0), //Colors.green,
            primaryVariant: Colors.red,
            secondary: Colors.blue,
            secondaryVariant: Colors.pink,
            surface: Colors.amber,
            background: Colors.white,//Color.fromRGBO(137, 172, 18, 1.0),
            error: Colors.amber,
            onPrimary: Colors.amber,
            onSecondary: Colors.amber,
            onSurface: Colors.amber,
            onBackground: Colors.amber,
            onError: Colors.amber,
            brightness: Brightness.light),
      ),
      // theme: ThemeData(
      // primaryColor: Colors.green,
      // background: Colors.green,
      // ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (context) => MyHomePage(),
      },
    );
  }
}
