import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:old_trustworthy/providers/shopping_cart_provider.dart';

class ProductsCart extends StatelessWidget {
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
                tooltip: 'Ver Carrito',
                onPressed: () {},
              ),
            ),
            Text(
              'Ver mi pedido \$${shoppingCart.getCounter.toStringAsFixed(2)}',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
      ),
    );
  }
}

// class ProductsCart extends StatefulWidget {
//   @override
//   _ProductsCartState createState() => _ProductsCartState();
// }

// class _ProductsCartState extends State<ProductsCart> {
//   ShoppingCartStream streamShoppingCart = ShoppingCartStream.instance;

//   @override
//   void dispose() {
//     streamShoppingCart.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       child: MaterialButton(
//         height: 40.0,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               child: IconButton(
//                 icon: Icon(Icons.shopping_cart),
//                 color: Colors.white,
//                 iconSize: 30,
//                 tooltip: 'Ver Carrito',
//                 onPressed: () {},
//               ),
//             ),
//             StreamBuilder<double>(
//               stream: streamShoppingCart.streamCount,
//               initialData: 0.0,
//               builder: (context, snapshot) {
//                 return Text(
//                   '\$${snapshot.data.toStringAsFixed(2)}',
//                   style: TextStyle(
//                     fontSize: 25.0,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 );
//               },
//             )
//           ],
//         ),
//         onPressed: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => MyProductsCartPage()));
//         },
//       ),
//     );
//   }
// }
