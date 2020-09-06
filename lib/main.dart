import 'package:flutter/material.dart';

import 'package:old_trustworthy/views/products_cart_page.dart';
import 'package:provider/provider.dart';

import 'package:old_trustworthy/providers/category_provider.dart';
import 'package:old_trustworthy/providers/login_provider.dart';
import 'package:old_trustworthy/providers/shopping_cart_provider.dart';
import 'package:old_trustworthy/providers/database_provider.dart';

import 'package:old_trustworthy/configs/preference.dart';

import 'package:old_trustworthy/views/home_page.dart';
import 'package:old_trustworthy/views/account_page.dart';
import 'package:old_trustworthy/views/address_page.dart';
import 'package:old_trustworthy/views/administration_page.dart';
import 'package:old_trustworthy/views/massive_message_page.dart';
import 'package:old_trustworthy/views/modify_delete_product_page.dart';
import 'package:old_trustworthy/views/product_loading_form_page.dart';

void main() => runApp(MyApp());

@override
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SharedPreferensesManager.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ShoppingCartProvider()),
          ChangeNotifierProvider(create: (context) => LoginProvider()),
          ChangeNotifierProvider(create: (context) => CategoryProvider()),
          ChangeNotifierProvider(create: (context) => DatabaseProvider()),
        ],
        child: MaterialApp(
          theme: ThemeData.from(
            colorScheme: ColorScheme(
              primary: Color.fromRGBO(47, 87, 44, 1.0), //color appbar y forms
              primaryVariant: Colors.pink, //nose q es
              secondary:
                  Color.fromRGBO(47, 87, 44, 1.0), // color iconos por fuera
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
          initialRoute: '/home',
          routes: {
            '/home': (context) => MyHomePage(),
            '/address': (context) => MyAddressPage(),
            '/account': (context) => MyAccountPage(),
            '/administration': (context) => MyAdministrationPage(),
            '/login': (context) => MyAdministrationPage(),
            '/massiveMessage': (context) => MassiveMessagePage(),
            '/cart': (context) => MyProductsCartPage(),
            '/modifyDelete': (context) => ModifyDeleteProductPage(),
            '/productLoading': (context) => ProductLoadingFormPage()
          },
        ));
  }
}
