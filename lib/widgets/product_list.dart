// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:old_trustworthy/models/product.dart';

class ProductList extends StatefulWidget {
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
    productRef.once().then((DataSnapshot snapshot) {
      var keys = snapshot.value.keys;
      var data = snapshot.value;

      productList.clear();

      for (var individualKey in keys) {
        Product products = Product(
            data[individualKey]['name'],
            data[individualKey]['price'],
            data[individualKey]['label'],
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
      height: 175.0,
      //color: Colors.greenAccent, // para ver el container
      child: productList.length == 0
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: productList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return _item(
                    productList[index].image,
                    productList[index].name,
                    productList[index].label,
                    productList[index].price,
                    productList[index].unit);
              },
              // children: <Widget>[
              //   _item(AssetImage('assets/products/manzana.jpg'), 'MANZANA',
              //       'VERDURAS', 60.56, 'KG'),
              //   _item(AssetImage('assets/products/zanahoria.jpg'), 'ZANAHORIA',
              //       'VERDURAS', 35, 'KG'),
              //   _item(AssetImage('assets/products/limon.jpg'), 'LIMON', 'VERDURAS',
              //       20.30, 'KG'),
              //   _item(AssetImage('assets/products/uva.jpg'), 'UVA', 'VERDURAS', 60.56,
              //       'KG'),
              // ],
            ),
    );
  }
}

Widget _item(
    String image, String name, String label, String price, String unit) {
  return Container(
    width: 175.0,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black, width: 3),
      borderRadius: BorderRadius.circular(20),
      image: DecorationImage(
        image: NetworkImage(image),
        fit: BoxFit.contain,
        alignment: Alignment.topCenter,
      ),
      //image, fit: BoxFit.contain, alignment: Alignment.topCenter),
    ),
    child: Column(
      children: <Widget>[
        // Image.network(
        //   image,
        //   fit: BoxFit.cover,
        // ),
        Padding(
          padding: EdgeInsets.only(top: 130),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          price + ' x ' + unit,
        ),
      ],
    ),
  );
}
