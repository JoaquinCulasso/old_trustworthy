import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:old_trustworthy/models/product.dart';
import 'package:old_trustworthy/providers/shopping_cart_provider.dart';
import 'package:old_trustworthy/widgets/send_cart_order.dart';

class MyProductsCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Carrito'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(
                Icons.remove_shopping_cart,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                _clearShoppingCart(context);
              })
        ],
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/vieja_confiable.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: context.watch<ShoppingCartProvider>().getCart.length == 0
              ? Center(
                  child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Text(
                    'Selecciona algunos productos para comenzar tu compra!!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ))
              : ListView.builder(
                  itemCount: context.select(
                      (ShoppingCartProvider shoppingCart) =>
                          shoppingCart.getCart.length),
                  itemBuilder: (BuildContext context, int index) {
                    return ItemProduct(
                      product:
                          context.read<ShoppingCartProvider>().getCart[index],
                    );
                  },
                ),
        ),
      ),
      bottomNavigationBar: SendCartOrder(),
    );
  }
}

Future<void> _clearShoppingCart(context) {
  final shoppingCartProvider =
      Provider.of<ShoppingCartProvider>(context, listen: false);
  return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Alerta!!!', style: TextStyle(fontSize: 25)),
          content: Text('¿Estas seguro de eliminar todos los productos?'),
          actions: <Widget>[
            RaisedButton(
              color: Color.fromRGBO(47, 87, 44, 1.0),
              child: Text('Aceptar', style: TextStyle(fontSize: 20)),
              onPressed: () {
                shoppingCartProvider.getCart.clear();
                shoppingCartProvider.resetCounter();
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              color: Color.fromRGBO(47, 87, 44, 1.0),
              child: Text('Cancelar', style: TextStyle(fontSize: 20)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}

class ItemProduct extends StatelessWidget {
  final Product product;

  const ItemProduct({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 160.0,
                width: 215.0,
                child: Column(
                  children: <Widget>[
                    Text(
                      product.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                    Text(
                      '\$${product.price} x ${product.unit}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AccountingBar(product: product)
                  ],
                ),
              ),
              Container(
                height: 150.0,
                width: 150.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  image: DecorationImage(
                    image: NetworkImage(product.image),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
            color: Colors.greenAccent[300],
            thickness: 2.5,
            height: 10.0,
            indent: 15,
            endIndent: 15),
      ],
    );
  }
}

class AccountingBar extends StatelessWidget {
  final Product product;

  const AccountingBar({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 200.0,
        decoration: BoxDecoration(
          color: Color.fromRGBO(82, 164, 112, 1.0),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(width: 2.0, color: Colors.black),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                highlightColor: Color.fromRGBO(47, 87, 44, 1.0),
                tooltip: 'Sumar',
                iconSize: 30.0,
                color: Colors.white,
                icon: Icon(Icons.add),
                onPressed: () {
                  context
                      .read<ShoppingCartProvider>()
                      .sumCounter(product.price);
                  context
                      .read<ShoppingCartProvider>()
                      .incrementCountProduct(product);
                },
              ),
              VerticalDivider(color: Colors.black, width: 2.0, thickness: 2.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  context.select((ShoppingCartProvider shoppingCart) =>
                      shoppingCart.getProductCount(product).toString()),
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              VerticalDivider(color: Colors.black, width: 2, thickness: 2),
              IconButton(
                highlightColor: Color.fromRGBO(47, 87, 44, 1.0),
                padding: EdgeInsets.all(0),
                iconSize: 30.0,
                tooltip: 'Restar',
                color: Colors.white,
                icon: Icon(Icons.remove),
                onPressed: () {
                  context
                      .read<ShoppingCartProvider>()
                      .subtracCounter(product.price);
                  context
                      .read<ShoppingCartProvider>()
                      .subtractCountProduct(product);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
