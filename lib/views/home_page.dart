import 'package:flutter/material.dart';

import 'package:old_trustworthy/widgets/products_cart.dart';
import 'package:old_trustworthy/widgets/drawer_left_bar.dart';
import 'package:old_trustworthy/widgets/product_list_horizontal.dart';
import 'package:old_trustworthy/widgets/product_title.dart';
import 'package:old_trustworthy/widgets/selection_categories.dart';

class MyHomePage extends StatelessWidget {
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
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SelectionCategories(),
                  Divider(color: Colors.black, thickness: 5.0, height: 0.0),
                  ProductTitle(title: 'Verduras'),
                  ProductListHorizontal(category: 'Verdura'), //Verduras
                  Divider(color: Colors.black, thickness: 5.0, height: 0.0),
                  ProductTitle(title: 'Frutas'),
                  ProductListHorizontal(category: 'Fruta'), //Frutas
                  Divider(color: Colors.black, thickness: 5.0, height: 0.0),
                  ProductTitle(title: 'Carnes'),
                  ProductListHorizontal(category: 'Carne'), //Carnes
                  Divider(color: Colors.black, thickness: 5.0, height: 0.0),
                  ProductTitle(title: 'Congelados'),
                  ProductListHorizontal(category: 'Congelados'), //Congelados
                  Divider(color: Colors.black, thickness: 5.0, height: 0.0),
                  ProductTitle(title: 'Higiene personal'),
                  ProductListHorizontal(
                      category: 'Higiene personal'), //Higiene personal
                  Divider(color: Colors.black, thickness: 5.0, height: 0.0),
                  ProductTitle(title: 'Limpieza'),
                  ProductListHorizontal(category: 'Limpieza'), //Limpieza
                  Divider(color: Colors.black, thickness: 5.0, height: 0.0),
                  ProductTitle(title: 'Fiambres'),
                  ProductListHorizontal(category: 'Fiambre'), //Fiambres
                  Divider(color: Colors.white, thickness: 5.0, height: 0.0),
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
