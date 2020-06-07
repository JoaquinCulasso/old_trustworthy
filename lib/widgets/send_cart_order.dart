import 'package:flutter/material.dart';
import 'package:old_trustworthy/providers/shopping_cart_provider.dart';
import 'package:provider/provider.dart';

class SendCartOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shoppingCart = Provider.of<ShoppingCartProvider>(context);

    return BottomAppBar(
      child: MaterialButton(
        height: 40.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                color: Colors.white,
                iconSize: 30,
                tooltip: 'Enviar pedido',
                onPressed: () {},
              ),
            ),
            Text(
              'Enviar pedido \$${shoppingCart.getCounter.toStringAsFixed(2)}',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        onPressed: () {},
      ),
    );
  }
}
