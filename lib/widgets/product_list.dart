import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:old_trustworthy/models/product.dart';
import 'package:old_trustworthy/providers/shopping_cart_provider.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  final String category;

  ProductList({Key key, this.category}) : super(key: key);
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> productList = [];

  @override
  void initState() {
    super.initState();

    DatabaseReference productRef =
        FirebaseDatabase.instance.reference().child('Vieja_Confiable');

    Query filterQuery = productRef.orderByChild('category').equalTo(widget.category);

    filterQuery.once().then((DataSnapshot snapshot) {
      var keys = snapshot.value.keys;
      var data = snapshot.value;

      productList.clear();

      for (var individualKey in keys) {
        Product products = Product(
            data[individualKey]['name'],
            data[individualKey]['price'],
            data[individualKey]['category'],
            data[individualKey]['unit'],
            data[individualKey]['image']);

        productList.add(products);
      }

      setState(() {
        print('Length: $productList.length');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: productList.length == 0
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: productList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return _item(
                    productList[index].image,
                    productList[index].name,
                    productList[index].category,
                    productList[index].price,
                    productList[index].unit,
                    context);
              },
            ),
    );
  }

  // Widget _item(String _image, String _name, String _category, String _price,
  //     String _unit, BuildContext context) {
  //   final shoppingCart = Provider.of<ShoppingCartProvider>(context);

  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 5.0),
  //     child: Container(
  //       width: 120.0,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         border: Border.all(color: Colors.black, width: 3),
  //         borderRadius: BorderRadius.circular(20),
  //         image: DecorationImage(
  //           image: NetworkImage(_image),
  //           fit: BoxFit.contain,
  //           alignment: Alignment.center,
  //         ),
  //       ),
  //       child: MaterialButton(
  //         padding: EdgeInsets.all(0),
  //         splashColor: Color.fromRGBO(25, 68, 11, 0.7),
  //         onPressed: () {
  //           shoppingCart.sumCounter(_price);
  //           shoppingCart.addCart(Product(_name, _price, _category, _unit, _image));
  //         },
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: <Widget>[
  //             Text(
  //               _name,
  //               textAlign: TextAlign.center,
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             Text(
  //               '\$$_price x $_unit',
  //               textAlign: TextAlign.center,
  //               style: TextStyle(
  //                 fontSize: 20.0,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _item(String _image, String _name, String _category, String _price,
      String _unit, BuildContext context) {
    final shoppingCart = Provider.of<ShoppingCartProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          MaterialButton(
            padding: EdgeInsets.all(0),
            splashColor: Colors.red, // Color.fromRGBO(25, 68, 11, 0.7),
            onPressed: () {
              shoppingCart.sumCounter(_price);
              shoppingCart
                  .addCart(Product(_name, _price, _category, _unit, _image));
            },
            child: Container(
              height: 90.0,
              width: 90.0,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(_image),
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Text(
                _name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$$_price x $_unit',
                style: TextStyle(
                  fontSize: 17.5,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
      // ),
    );
  }
}

// class ProductList extends StatefulWidget {
//   @override
//   _ProductListState createState() => _ProductListState();
// }

// class _ProductListState extends State<ProductList> {
//   List<Product> productList = [];
//   ShoppingCartStream streamShoppingCart;

//   @override
//   void initState() {
//     super.initState();

//     streamShoppingCart = ShoppingCartStream.instance;
//     streamShoppingCart.resetCount();

//     DatabaseReference productRef =
//         FirebaseDatabase.instance.reference().child('Vieja_Confiable');
//     productRef.once().then((DataSnapshot snapshot) {
//       var keys = snapshot.value.keys;
//       var data = snapshot.value;

//       productList.clear();

//       for (var individualKey in keys) {
//         Product products = Product(
//             data[individualKey]['name'],
//             data[individualKey]['price'],
//             data[individualKey]['category'],
//             data[individualKey]['unit'],
//             data[individualKey]['image']);

//         productList.add(products);
//       }

//       setState(() {
//         print('Length: $productList.length');
//       });
//     });
//   }

//   @override
//   void dispose() {
//     streamShoppingCart.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 150.0,
//       child: productList.length == 0
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: productList.length,
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (_, index) {
//                 return _item(
//                     productList[index].image,
//                     productList[index].name,
//                     productList[index].category,
//                     productList[index].price,
//                     productList[index].unit);
//               },
//             ),
//     );
//   }

//   Widget _item(
//       String _image, String _name, String _category, String _price, String _unit) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 5.0),
//       child: Container(
//         width: 150.0,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(color: Colors.black, width: 3),
//           borderRadius: BorderRadius.circular(20),
//           image: DecorationImage(
//             image: NetworkImage(_image),
//             fit: BoxFit.contain,
//             alignment: Alignment.center,
//           ),
//         ),
//         child: MaterialButton(
//           padding: EdgeInsets.all(0),
//           splashColor: Color.fromRGBO(25, 68, 11, 0.7),
//           onPressed: () {
//             streamShoppingCart.incrementCounter(_price);
//             // streamShoppingCart
//             //     .addProduct(Product(_name, _price, _category, _unit, _image));
//           },
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text(
//                 _name,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 '\$$_price x $_unit',
//                 style: TextStyle(
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
