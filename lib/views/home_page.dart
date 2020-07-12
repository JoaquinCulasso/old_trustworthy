import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:old_trustworthy/providers/category_provider.dart';

import 'package:old_trustworthy/widgets/products_cart.dart';
import 'package:old_trustworthy/widgets/product_list_vertical.dart';
import 'package:old_trustworthy/widgets/product_list_horizontal.dart';
import 'package:old_trustworthy/widgets/product_title.dart';
import 'package:old_trustworthy/widgets/selection_categories.dart';
import 'package:old_trustworthy/widgets/drawer_left_bar.dart';

class MyHomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    final CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context);

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
          child: Column(
            children: <Widget>[
              SelectionCategories(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        categoryProvider.selected
                            ? _bodyListVertical(categoryProvider, context)
                            : _bodyListHorizontal(categoryProvider),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: DrawerLeftBar(),
      bottomNavigationBar: ProductsCart(),
    );
  }

  Widget _bodyListVertical(CategoryProvider categoryProvider, context) {
    return ProductListVertical(
      category: categoryProvider.categoryActive,
    );
  }

  Widget _bodyListHorizontal(CategoryProvider categoryProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Divider(color: Colors.black, thickness: 5.0, height: 0.0),
        ProductTitle(title: 'Verduras'),
        ProductListHorizontal(category: 'Verduras'), //Verduras
        Divider(color: Colors.black, thickness: 5.0, height: 0.0),
        ProductTitle(title: 'Frutas'),
        ProductListHorizontal(category: 'Frutas'), //Frutas
        Divider(color: Colors.black, thickness: 5.0, height: 0.0),
        ProductTitle(title: 'Lacteos fiambres'),
        ProductListHorizontal(category: 'Lacteos fiambres'), // Lacteos Fiambres
        Divider(color: Colors.black, thickness: 5.0, height: 0.0),
        ProductTitle(title: 'Carnes'),
        ProductListHorizontal(category: 'Carnes'), //Carnes
        Divider(color: Colors.black, thickness: 5.0, height: 0.0),
        ProductTitle(title: 'Congelados'),
        ProductListHorizontal(category: 'Congelados'), //Congelados
        Divider(color: Colors.black, thickness: 5.0, height: 0.0),
        ProductTitle(title: 'Higiene personal'),
        ProductListHorizontal(category: 'Higiene personal'), //Higiene personal
        Divider(color: Colors.black, thickness: 5.0, height: 0.0),
        ProductTitle(title: 'Limpieza'),
        ProductListHorizontal(category: 'Limpieza'), //Limpieza
        Divider(color: Colors.black, thickness: 5.0, height: 0.0),
        ProductTitle(title: 'Almacen'),
        ProductListHorizontal(category: 'Almacen'), //Fiambres
      ],
    );
  }
}
