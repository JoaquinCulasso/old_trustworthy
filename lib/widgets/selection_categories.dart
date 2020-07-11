import 'package:flutter/material.dart';

import '../old_trustworthy_icons.dart';

class SelectionCategories extends StatefulWidget {
  @override
  _SelectionCategoriesState createState() => _SelectionCategoriesState();
}

class _SelectionCategoriesState extends State<SelectionCategories> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _bottonAction(OldTrustworthyIcons.carnes, () {}),
            _bottonAction(OldTrustworthyIcons.congelados, () {}),
            _bottonAction(OldTrustworthyIcons.frutas, () {}),
            _bottonAction(OldTrustworthyIcons.higiene_personal, () {}),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _bottonAction(OldTrustworthyIcons.lacteos_fiambres, () {}),
            _bottonAction(OldTrustworthyIcons.limpieza, () {}),
            _bottonAction(OldTrustworthyIcons.verduras, () {}),
            _bottonAction(OldTrustworthyIcons.verduras, () {}),
          ],
        ),
      ],
    );
  }
}

Widget _bottonAction(IconData icon, Function callback) {
  return InkWell(
    borderRadius: BorderRadius.circular(25),
    child: Padding(
      padding: EdgeInsets.all(15.0),
      child: Icon(icon),
    ),
    onTap: callback,
  );
}
