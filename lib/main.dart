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
          primary: Color.fromRGBO(47, 87, 44, 1.0), //color appbar y forms
          primaryVariant: Colors.pink, //nose q es
          secondary: Color.fromRGBO(47, 87, 44, 1.0), // color iconos por fuera
          secondaryVariant: Colors.pink, //nose q es
          surface: Color.fromRGBO(47, 87, 44, 1.0), //app bar botton
          background: Colors.white, //color fondo
          error: Colors.red, //error q salta en los formularios
          onPrimary: Colors.pink, // nose q es
          onSecondary: Colors.white, //color iconos por dentro
          onSurface: Colors.black, // son las lineas de los formularios
          onBackground: Colors.pink, // nose q es
          onError: Colors.pink, // nose q es
          brightness: Brightness.light, // nose q es
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (context) => MyHomePage(),
      },
    );
  }
}
