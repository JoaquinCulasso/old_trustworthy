import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:old_trustworthy/models/product.dart';
import 'package:old_trustworthy/providers/shopping_cart_provider.dart';

class ProductListVertical extends StatefulWidget {
  final String category;

  ProductListVertical({Key key, this.category}) : super(key: key);
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductListVertical> {
  List<Product> productList = [];

  @override
  Widget build(BuildContext context) {
    final ShoppingCartProvider shoppingCart =
        Provider.of<ShoppingCartProvider>(context);

    setState(() {
      DatabaseReference productRef =
          FirebaseDatabase.instance.reference().child('Vieja_Confiable');

      Query filterQuery =
          productRef.orderByChild('category').equalTo(widget.category);

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
    });

    // final CategoryProvider categoryProvider =
    //     Provider.of<CategoryProvider>(context);

    return Column(
      children: <Widget>[
        productList.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: productList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return _item(
                      productList[index].image,
                      productList[index].name,
                      productList[index].category,
                      productList[index].price,
                      productList[index].unit,
                      context,
                      shoppingCart);
                },
              ),
      ],
    );
  }

  Widget _item(String _image, String _name, String _category, String _price,
      String _unit, BuildContext context, ShoppingCartProvider shoppingCart) {
    return Column(
      children: <Widget>[
        MaterialButton(
          padding: EdgeInsets.all(0),
          splashColor: Colors.red, // Color.fromRGBO(25, 68, 11, 0.7),
          onPressed: () {
            shoppingCart.sumCounter(_price);
            shoppingCart
                .addCart(Product(_name, _price, _category, _unit, _image));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Container(
                height: 150.0,
                width: 200.0,
                child: Column(
                  children: <Widget>[
                    Text(
                      _name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                    Text(
                      '\$$_price x $_unit',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
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
                  color: Colors.white,
                  image: DecorationImage(
                    image: NetworkImage(_image),
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

  // Widget _item(String _image, String _name, String _category, String _price,
  //     String _unit, BuildContext context) {
  //   final shoppingCart = Provider.of<ShoppingCartProvider>(context);

  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 5.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.max,
  //       children: <Widget>[
  //         MaterialButton(
  //           padding: EdgeInsets.all(0),
  //           splashColor: Colors.red, // Color.fromRGBO(25, 68, 11, 0.7),
  //           onPressed: () {
  //             shoppingCart.sumCounter(_price);
  //             shoppingCart
  //                 .addCart(Product(_name, _price, _category, _unit, _image));
  //           },
  //           child: Container(
  //             height: 90.0,
  //             width: 90.0,
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               border: Border.all(color: Colors.black, width: 3),
  //               borderRadius: BorderRadius.circular(20),
  //               image: DecorationImage(
  //                 image: NetworkImage(_image),
  //                 fit: BoxFit.contain,
  //                 alignment: Alignment.center,
  //               ),
  //             ),
  //           ),
  //         ),
  //         Column(
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
  //               style: TextStyle(
  //                 fontSize: 17.5,
  //                 // fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //     // ),
  //   );
  // }
}
