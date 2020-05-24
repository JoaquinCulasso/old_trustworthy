import 'package:flutter/material.dart';

class ProductTitle extends StatelessWidget {
  final String title;

  const ProductTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 25.0,
              color: Color.fromRGBO(47, 87, 44, 1.0),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
