import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:old_trustworthy/models/product.dart';
// import 'package:old_trustworthy/streams/product_cart_list_stream.dart';
import 'package:old_trustworthy/streams/sum_prices_stream.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> productList = [];
  SumPricesStream streamPrices; // = SumPricesStream.instance;
  // ProductCartListStream streamCartProduct;// = ProductCartListStream.instance;

  @override
  void initState() {
    super.initState();

    streamPrices = SumPricesStream.instance;
    // streamCartProduct = ProductCartListStream.instance;
    streamPrices.resetCount();

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
  void dispose() {
    streamPrices.close();
    super.dispose();
    // streamPrices.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      // color: Colors.white,
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
            ),
    );
  }

  Widget _item(
      String _image, String _name, String _label, String _price, String _unit) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        width: 150.0,
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
        child: MaterialButton(
          padding: EdgeInsets.all(0),
          splashColor: Color.fromRGBO(25, 68, 11, 0.7),
          onPressed: () {
            streamPrices.incrementCount(_price);
            // streamCartProduct
            //     .addProduct(Product(_name, _price, _label, _unit, _image));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$$_price x $_unit',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
