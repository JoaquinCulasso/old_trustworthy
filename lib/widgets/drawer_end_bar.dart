import 'package:flutter/material.dart';

class DrawerEndBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Barra donde estaria el carrito y listado de cosas'),
        ],
      ),
    );
  }
}
