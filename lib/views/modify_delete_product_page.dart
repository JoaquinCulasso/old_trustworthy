import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:old_trustworthy/models/product.dart';
import 'package:old_trustworthy/providers/database_provider.dart';
import 'package:old_trustworthy/views/product_update_form_page.dart';
import 'package:provider/provider.dart';

class ModifyDeleteProductPage extends StatefulWidget {
  @override
  _ModifyDeleteProductPageState createState() =>
      _ModifyDeleteProductPageState();
}

class _ModifyDeleteProductPageState extends State<ModifyDeleteProductPage> {
  // List productList = [];

  // @override
  // void initState() {
  //   super.initState();

  //   DatabaseReference productRef =
  //       FirebaseDatabase.instance.reference().child('Vieja_Confiable');

  //   productRef.once().then((DataSnapshot snapshot) {
  //     var keys = snapshot.value.keys;
  //     var data = snapshot.value;

  //     productList.clear();

  //     for (var individualKey in keys) {
  //       Product products = Product(
  //           data[individualKey]['name'],
  //           data[individualKey]['price'],
  //           data[individualKey]['category'],
  //           data[individualKey]['unit'],
  //           data[individualKey]['image']);

  //       productList.add(products);
  //     }

  //     setState(() {
  //       print('Length: $productList.length');
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final databaseProvider = Provider.of<DatabaseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Modificar/eliminar productos'),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) => (databaseProvider.productList.length == 0
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: ListView.builder(
                  itemCount: databaseProvider.productList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (_, index) {
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                height: 180.0,
                                width: 215.0,
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      databaseProvider.productList[index]
                                          .name, //productList[index].name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 22.0,
                                      ),
                                    ),
                                    Text(
                                      //'\$${productList[index].price} x ${productList[index].unit}',
                                      '\$${databaseProvider.productList[index].price} x ${databaseProvider.productList[index].unit}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      //'${productList[index].category}',
                                      '${databaseProvider.productList[index].category}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    //_modifyDelProductBar(productList[index]),
                                    _modifyDelProductBar(
                                        databaseProvider.productList[index],
                                        databaseProvider,
                                        context),
                                  ],
                                ),
                              ),
                              Container(
                                height: 150.0,
                                width: 150.0,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 3),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: DecorationImage(
                                    // image: NetworkImage(productList[index].image),
                                    image: NetworkImage(databaseProvider
                                        .productList[index].image),
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
                  },
                ),
              )),
      ),
    );
  }

  Widget _modifyDelProductBar(Product product,
      DatabaseProvider databaseProvider, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 50,
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
                tooltip: 'Modificar',
                iconSize: 30.0,
                color: Colors.white,
                icon: Icon(Icons.edit),
                onPressed: () {
                  _modifyProduct(product);
                },
              ),
              VerticalDivider(color: Colors.black, width: 2, thickness: 2),
              IconButton(
                highlightColor: Color.fromRGBO(47, 87, 44, 1.0),
                padding: EdgeInsets.all(0),
                iconSize: 30.0,
                tooltip: 'Eliminar',
                color: Colors.white,
                icon: Icon(CupertinoIcons.delete_simple),
                onPressed: () {
                  _deleteProduct(product, databaseProvider, context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _modifyProduct(Product product) {
    return showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            title: Text('Modificar producto', style: TextStyle(fontSize: 25)),
            content: Text(
              'Producto: ${product.name}.\nPrecio: \$${product.price}.\nUnidad: ${product.unit}.\nCategoria: ${product.category}.',
              style: TextStyle(fontSize: 20),
            ),
            actions: <Widget>[
              RaisedButton(
                color: Color.fromRGBO(47, 87, 44, 1.0),
                child: Text('Aceptar', style: TextStyle(fontSize: 20)),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ProductUpdateFormPage(product: product)));
                  });
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

  Future _deleteProduct(Product product, DatabaseProvider databaseProvider,
      BuildContext context) {
    return showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            title: Text('Eliminar producto', style: TextStyle(fontSize: 25)),
            content: Text(
                'Producto: ${product.name}.\nPrecio: \$${product.price}.\nUnidad: ${product.unit}.\nCategoria: ${product.category}.',
                style: TextStyle(fontSize: 20)),
            actions: <Widget>[
              RaisedButton(
                color: Color.fromRGBO(47, 87, 44, 1.0),
                child: Text('Aceptar', style: TextStyle(fontSize: 20)),
                onPressed: () {
                  Navigator.of(context).pop();
                  databaseProvider.deleteProduct(product, context);
                  _progressAlertDialog(context);
                  // setState(() {
                  //delete image from FirebaseStorage
                  // FirebaseStorage.instance
                  //     .ref()
                  //     .child("Vieja_Confiable")
                  //     .getStorage()
                  //     .getReferenceFromUrl(product.image)
                  //     .then((value) => value.delete());

                  // databaseProvider.deleteImageStorage(product);
                  //delete product from view list
                  // productList.remove(product);
                  // databaseProvider.deleteDataOfDatabase(product);

                  //delete from realtime database
                  // FirebaseDatabase.instance
                  //     .reference()
                  //     .child('Vieja_Confiable')
                  //     .orderByChild('image')
                  //     .equalTo(product.image)
                  //     .onChildAdded
                  //     .listen((event) {
                  //   FirebaseDatabase.instance
                  //       .reference()
                  //       .child('Vieja_Confiable')
                  //       .child(event.snapshot.key)
                  //       .remove();
                  // }, onError: (Object o) {
                  //   final DatabaseError error = o;
                  //   print('Error: ${error.code} ${error.message}');
                  // });
                  // });
                  // Navigator.of(context).pop();
                },
              ),
              RaisedButton(
                color: Color.fromRGBO(47, 87, 44, 1.0),
                child: Text('Cancelar', style: TextStyle(fontSize: 20)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future _progressAlertDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (buildContext) {
          return Center(
            child: AlertDialog(
              title: Text('Eliminando....', style: TextStyle(fontSize: 25)),
              content: Center(
                  heightFactor: 1.5,
                  widthFactor: 1.5,
                  child: CircularProgressIndicator()),
            ),
          );
        });
  }
}
