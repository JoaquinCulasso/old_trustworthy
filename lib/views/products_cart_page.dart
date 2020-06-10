import 'package:flutter/material.dart';
import 'package:old_trustworthy/models/product.dart';
import 'package:old_trustworthy/providers/shopping_cart_provider.dart';
import 'package:old_trustworthy/widgets/send_cart_order.dart';
import 'package:provider/provider.dart';

class MyProductsCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ShoppingCartProvider shoppingCart =
        Provider.of<ShoppingCartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Carrito'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/vieja_confiable.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: shoppingCart.getCart.length == 0
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
                  itemCount: shoppingCart.getCart.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _itemProduct(shoppingCart.getCart[index]);
                  },
                ),
        ),
      ),
      bottomNavigationBar: SendCartOrder(),
    );
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
                    accountingBar(),
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

  Widget accountingBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 150.0,
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
                splashColor: Color.fromRGBO(47, 87, 44, 1.0),
                tooltip: 'Sumar',
                iconSize: 30.0,
                color: Colors.white,
                icon: Icon(Icons.add),
                onPressed: () {},
              ),
              VerticalDivider(color: Colors.black, width: 2.0, thickness: 2.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Text(
                  '0',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              VerticalDivider(color: Colors.black, width: 2, thickness: 2),
              IconButton(
                splashColor: Color.fromRGBO(47, 87, 44, 1.0),
                padding: EdgeInsets.all(0),
                iconSize: 30.0,
                tooltip: 'Restar',
                color: Colors.white,
                icon: Icon(Icons.remove),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
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
