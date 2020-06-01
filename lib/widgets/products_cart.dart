import 'package:flutter/material.dart';
import 'package:old_trustworthy/streams/sum_prices_stream.dart';

import 'package:old_trustworthy/views/products_cart_page.dart';

class ProductsCart extends StatefulWidget {
  @override
  _ProductsCartState createState() => _ProductsCartState();
}

class _ProductsCartState extends State<ProductsCart> {
  SumPricesStream streamsPrices = SumPricesStream.instance;

  @override
  void dispose() {
    streamsPrices.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                tooltip: 'Ver Carrito',
                onPressed: () {},
              ),
            ),
            StreamBuilder<double>(
                stream: streamsPrices.streamCount,
                initialData: 0.0,
                builder: (context, snapshot) {
                  return Text(
                    '\$${snapshot.data.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                })
          ],
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyProductsCartPage()));
        },
      ),
    );
  }
}
