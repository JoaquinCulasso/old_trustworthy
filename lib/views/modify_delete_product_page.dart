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
  @override
  Widget build(BuildContext context) {
    final databaseProvider =
        Provider.of<DatabaseProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Modificar/eliminar productos'),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) => (FutureBuilder(
          future: databaseProvider.getDataOfDatabase(),
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
          },
        )),
      ),
    );
  }
}

void _snackBarError(BuildContext context, String textError) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    Scaffold.of(context).showSnackBar(
        SnackBar(duration: Duration(seconds: 8), content: Text(textError)));
  });
}

class ListVertical extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final databaseProvider = Provider.of<DatabaseProvider>(context);

    return SafeArea(
      child: ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
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
                            databaseProvider.productList[index].name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                          Text(
                            '\$${databaseProvider.productList[index].price} x ${databaseProvider.productList[index].unit}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${databaseProvider.productList[index].category}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ModifyDelProductBar(
                              product: databaseProvider.productList[index]),
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
                          image: NetworkImage(
                              databaseProvider.productList[index].image),
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
    );
  }
}

class ModifyDelProductBar extends StatefulWidget {
  final Product product;

  const ModifyDelProductBar({Key key, this.product}) : super(key: key);

  @override
  _ModifyDelProductBarState createState() => _ModifyDelProductBarState();
}

class _ModifyDelProductBarState extends State<ModifyDelProductBar> {
  @override
  Widget build(BuildContext context) {
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
                  _modifyProduct(widget.product);
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
                  _deleteProduct(widget.product, context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _modifyProduct(Product product) {
    return showDialog(
        context: context,
        builder: (_) {
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

  Future<void> _deleteProduct(Product product, BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
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
                  Provider.of<DatabaseProvider>(context, listen: false)
                      .deleteProduct(product, context);
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
}

class LoadingData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
