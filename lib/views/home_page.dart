import 'package:flutter/material.dart';

import 'package:old_trustworthy/widgets/products_cart.dart';
import 'package:old_trustworthy/widgets/drawer_left_bar.dart';
import 'package:old_trustworthy/widgets/product_list.dart';
import 'package:old_trustworthy/widgets/product_title.dart';
import 'package:old_trustworthy/widgets/selection_labels.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Vieja Confiable',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/vieja_confiable.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SelectionLabels(),
                  Divider(color: Colors.black, thickness: 5.0, height: 50.0),
                  ProductTitle(title: 'Verduras'),
                  ProductList(), //Verduras
                  Divider(color: Colors.black, thickness: 5.0, height: 50.0),
                  ProductTitle(title: 'Frutas'),
                  ProductList(), //Frutas
                  Divider(color: Colors.black, thickness: 5.0, height: 50.0),
                  ProductTitle(title: 'Carnes'),
                  ProductList(), //Carnes
                  Divider(color: Colors.black, thickness: 5.0, height: 50.0),
                  ProductTitle(title: 'Congelados'),
                  ProductList(), //Congelados
                  Divider(color: Colors.black, thickness: 5.0, height: 50.0),
                  ProductTitle(title: 'Higiene personal'),
                  ProductList(), //Higiene personal
                  Divider(color: Colors.black, thickness: 5.0, height: 50.0),
                  ProductTitle(title: 'Limpieza'),
                  ProductList(), //Limpieza
                  Divider(color: Colors.black, thickness: 5.0, height: 50.0),
                  ProductTitle(title: 'Fiambres'),
                  ProductList(), //Fiambres
                  Divider(color: Colors.white, thickness: 5.0, height: 50.0),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: DrawerLeftBar(),
      bottomNavigationBar: ProductsCart(),
    );
  }
}
