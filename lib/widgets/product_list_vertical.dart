import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:old_trustworthy/providers/database_provider.dart';
import 'package:old_trustworthy/providers/shopping_cart_provider.dart';

import 'package:old_trustworthy/models/product.dart';

class ProductListVertical extends StatefulWidget {
  final String category;

  ProductListVertical({Key key, this.category}) : super(key: key);
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductListVertical> {
  @override
  Widget build(BuildContext context) {
    final databaseProvider =
        Provider.of<DatabaseProvider>(context, listen: false);

    return FutureBuilder(
        future: databaseProvider.getProductListVertical(widget.category),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              _snackBarError(context,
                  'Error en la conexión, por favor actualice la pantalla...');
              return LoadingData();
            case ConnectionState.waiting:
              return LoadingData();
            case ConnectionState.active:
              return LoadingData();
            case ConnectionState.done:
              if (databaseProvider.databaseState.hasError) {
                _snackBarError(context,
                    'Error buscando datos, por favor actualice la pantalla...');
              }
              if (!snapshot.hasData || snapshot.data.isEmpty) {
                return LoadingData();
              }

              return ListVertical();
          }
          return null;
        });
  }
}

void _snackBarError(BuildContext context, String textError) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    Scaffold.of(context).showSnackBar(
        SnackBar(duration: Duration(seconds: 3), content: Text(textError)));
  });
}

class LoadingData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 170),
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class ListVertical extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final databaseProvider =
        Provider.of<DatabaseProvider>(context, listen: false);

    return Column(
      children: <Widget>[
        ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: databaseProvider.productListVertical.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Item(
              image: databaseProvider.productListVertical[index].image,
              name: databaseProvider.productListVertical[index].name,
              category: databaseProvider.productListVertical[index].category,
              price: databaseProvider.productListVertical[index].price,
              unit: databaseProvider.productListVertical[index].unit,
            );
          },
        ),
      ],
    );
  }
}

class Item extends StatelessWidget {
  final String image, name, category, price, unit;

  const Item(
      {Key key, this.image, this.name, this.category, this.price, this.unit})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final shoppingCart =
        Provider.of<ShoppingCartProvider>(context, listen: false);

    return Column(
      children: <Widget>[
        MaterialButton(
          padding: EdgeInsets.all(0),
          splashColor: Colors.red,
          onPressed: () {
            shoppingCart.sumCounter(price);
            shoppingCart.addCart(Product(name, price, category, unit, image));
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
                      name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                    Text(
                      '\$$price x $unit',
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
                    image: NetworkImage(image),
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
