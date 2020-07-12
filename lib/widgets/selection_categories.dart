import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:old_trustworthy/providers/category_provider.dart';

import '../old_trustworthy_icons.dart';

class SelectionCategories extends StatefulWidget {
  @override
  _SelectionCategoriesState createState() => _SelectionCategoriesState();
}

class _SelectionCategoriesState extends State<SelectionCategories> {
  @override
  Widget build(BuildContext context) {
    final CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buttonAction(
                  'Carnes', OldTrustworthyIcons.carnes, categoryProvider),
              _buttonAction('Congelados', OldTrustworthyIcons.congelados,
                  categoryProvider),
              _buttonAction(
                  'Frutas', OldTrustworthyIcons.frutas, categoryProvider),
              _buttonAction('Higiene personal',
                  OldTrustworthyIcons.higiene_personal, categoryProvider),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buttonAction('Lacteos fiambres',
                  OldTrustworthyIcons.lacteos_fiambres, categoryProvider),
              _buttonAction(
                  'Limpieza', OldTrustworthyIcons.limpieza, categoryProvider),
              _buttonAction(
                  'Verduras', OldTrustworthyIcons.verduras, categoryProvider),
              _buttonAction(
                  'Almacen', OldTrustworthyIcons.verduras, categoryProvider),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buttonAction(
    String name, IconData icon, CategoryProvider categoryProvider) {
  return RaisedButton(
    splashColor: Colors.red,
    shape: CircleBorder(
      side: BorderSide(
        color: categoryProvider.categoryActive == name
            ? Colors.blueAccent
            : Colors.grey,
        width: categoryProvider.categoryActive == name ? 3.0 : 1.0,
        style: BorderStyle.solid,
      ),
    ),
    child: Padding(
      padding: EdgeInsets.all(12.0),
      child: Icon(icon),
    ),
    onPressed: () {
      categoryProvider.selectedCategory(name);
    },
  );
}
