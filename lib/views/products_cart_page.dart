import 'package:flutter/material.dart';
import 'package:old_trustworthy/models/product.dart';
import 'package:old_trustworthy/providers/shopping_cart_provider.dart';
import 'package:provider/provider.dart';

class MyProductsCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ShoppingCartProvider shoppingCart =
        Provider.of<ShoppingCartProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Carrito de productos a comprar'),
        ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/vieja_confiable.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView.builder(
              itemCount: shoppingCart.getCart.length,
              itemBuilder: (BuildContext context, int index) {
                return _itemProduct(shoppingCart.getCart[index]);
              },
            ),
          ),
        ));
  }

  Widget _itemProduct(Product product) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 150.0,
                width: 215.0,
                // color: Colors.red,
                child: Column(
                  children: <Widget>[
                    Text(
                      product.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                    Text(
                      '\$${product.price} x ${product.unit}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 150.0,
                width: 150.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(20),
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

// class MyProductsCartPage extends StatefulWidget {
//   @override
//   _MyProductsCartPageState createState() => _MyProductsCartPageState();
// }

// class _MyProductsCartPageState extends State<MyProductsCartPage> {
//   ShoppingCartStream streamShoppingCart;

//   @override
//   void initState() {
//     streamShoppingCart = ShoppingCartStream.instance;

//     super.initState();
//   }

//   @override
//   void dispose() {
//     // streamCartProduct.close();
//     streamShoppingCart.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Carrito de productos a comprar'),
//       ),
//       body: StreamBuilder<Product>(
//           // stream: streamCartProduct.streamProduct,
//           stream: streamShoppingCart.streamAddProductCart,
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return Center(
//                 heightFactor: 20.0,
//                 child: CircularProgressIndicator(),
//               );
//             }
//             return Text('OK');
//             // return _itemProduct(snapshot.data);
//             // _itemProduct(),
//             // Divider(color: Colors.black, thickness: 5.0, height: 50.0),
//             // _itemProduct(),
//             // Divider(color: Colors.black, thickness: 5.0, height: 50.0),
//             // _itemProduct(),
//             // Divider(color: Colors.black, thickness: 5.0, height: 50.0),
//             // _itemProduct(),
//             // Divider(color: Colors.black, thickness: 5.0, height: 50.0),
//             // _itemProduct(),
//           }),
//     );
//   }
