import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:old_trustworthy/models/product.dart';
import 'package:old_trustworthy/state/database_state.dart';

class DatabaseProvider with ChangeNotifier {
  //list of data base
  final List _productList = [];

  List get productList => this._productList;

  //referende Storage
  final StorageReference _imageRef =
      FirebaseStorage.instance.ref().child("Vieja_Confiable");

  //reference Database
  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.reference().child("Vieja_Confiable");

  //database state
  final DatabaseState _databaseState = DatabaseState();

  DatabaseState get databaseState => this._databaseState;

  //load pruduct to database
  Future<void> loadProduct(File productImage, String name, String price,
      String unit, String category, context) async {
    _databaseState.loading();
    notifyListeners();

    String _url = await loadImageStorage(productImage);

    if (!_databaseState.hasError) {
      await loadDataDb(_url, name, price, unit, category);
    }

    _databaseState.isLoaded
        ? Navigator.pop(context)
        : WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Scaffold.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 8),
                content: Text(_databaseState.lastError)));
          });
    getDataOfDatabase();
    notifyListeners();
  }

  //update product to database
  Future<void> updateProduct(
      Product product, File productImage, BuildContext context) async {
    String url;
    _databaseState.loading();
    notifyListeners();

    if (productImage != null) {
      await deleteImageStorage(product);
      url = await loadImageStorage(productImage);
    } else {
      url = product.image;
    }

    if (!_databaseState.hasError) {
      await updateDataDb(url, product.image, product.name, product.price,
          product.unit, product.category);
    }

    _databaseState.isLoaded
        ? Navigator.of(context).pop() //popAndPushNamed('/modifyDelete')
        : _snackBarError(context);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //     Scaffold.of(context).showSnackBar(SnackBar(
    //         duration: Duration(seconds: 8),
    //         content: Text(_databaseState.lastError)));
    //   });
    getDataOfDatabase();
    notifyListeners();
  }

  //delete product to database
  Future<void> deleteProduct(Product product, BuildContext context) async {
    _databaseState.loading();
    notifyListeners();

    await deleteImageStorage(product);

    if (!_databaseState.hasError) {
      await deleteDataOfDatabase(product);
    }
    if (!_databaseState.hasError) {
      _productList.remove(product);
    }

    _databaseState.isLoaded
        ? Navigator.of(context).pop()
        : _snackBarError(context);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //     Scaffold.of(context).showSnackBar(SnackBar(
    //         duration: Duration(seconds: 8),
    //         content: Text(_databaseState.lastError)));
    //   });
    notifyListeners();
  }

  void _snackBarError(BuildContext context) {
    Navigator.of(context).pop();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Scaffold.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 8),
          content: Text(_databaseState.lastError)));
    });
  }

  //delete image of storage
  Future<void> deleteImageStorage(Product product) async {
    try {
      await _imageRef
          .getStorage()
          .getReferenceFromUrl(product.image)
          .then((value) => value.delete());
    } catch (lastError) {
      _databaseState.error('Error eliminando imagen: ' + lastError.toString());
    }
  }

  //delete data of database
  Future<void> deleteDataOfDatabase(Product product) async {
    try {
      _databaseRef
          .orderByChild('image')
          .equalTo(product.image)
          .onChildAdded
          .listen((event) {
        _databaseRef.child(event.snapshot.key).remove();
      });
      await Future.delayed(Duration(milliseconds: 6000));

      _databaseState.loaded();
    } catch (lastError) {
      _databaseState.error('Error eliminando imagen: ' + lastError.toString());
    }
  }

  //load image to storage
  Future<String> loadImageStorage(File productImage) async {
    String url;

    final StorageUploadTask uploadTask = _imageRef
        .child(DateTime.now().toString() + ".jpg")
        .putFile(productImage);

    try {
      var image = await (await uploadTask.onComplete).ref.getDownloadURL();
      url = image.toString();
    } catch (lastError) {
      _databaseState
          .error('Error subiendo imagen producto: ' + lastError.toString());
    }

    return url;
  }

  //load data to database
  Future<void> loadDataDb(String _url, String _name, String _price,
      String _unit, String _category) async {
    var dbTimeKey = DateTime.now();
    var formatDate = DateFormat('MMM d, yyyy');
    var formatTime = DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    var data = {
      "image": _url,
      "name": _name,
      "price": _price,
      "unit": _unit,
      "category": _category,
      "date": date,
      "time": time
    };

    //push to data
    try {
      await _databaseRef.push().set(data);
      _databaseState.loaded();
    } catch (lastError) {
      _databaseState
          .error('Error subiendo datos producto: ' + lastError.toString());
      await deleteImageStorage(Product(_name, _price, _unit, _category, _url));
    }
  }

  //update data of db
  Future<void> updateDataDb(String _newUrl, String _oldUrl, String _name,
      String _price, String _unit, String _category) async {
    // update post (image, name, price, unit, category, date, time)
    var dbTimeKey = DateTime.now();
    var formatDate = DateFormat('MMM d, yyyy');
    var formatTime = DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    var data = {
      "image": _newUrl,
      "name": _name,
      "price": _price,
      "unit": _unit,
      "category": _category,
      "date": date,
      "time": time
    };

    try {
      _databaseRef
          .orderByChild('image')
          .equalTo(_oldUrl)
          .onChildAdded
          .listen((event) {
        _databaseRef.child(event.snapshot.key).update(data);
        // .then((value) => value);
      });
      _databaseState.loaded();
    } catch (lastError) {
      _databaseState
          .error('Error actualizando datos productos: ' + lastError.toString());
    }
  }

  //constructor
  DatabaseProvider() {
    getDataOfDatabase();
  }

  //get data of database
  void getDataOfDatabase() async {
    try {
      await _databaseRef.once().then((DataSnapshot snapshot) {
        var keys = snapshot.value.keys;
        var data = snapshot.value;
        _productList.clear();

        for (var individualKey in keys) {
          Product products = Product(
              data[individualKey]['name'],
              data[individualKey]['price'],
              data[individualKey]['category'],
              data[individualKey]['unit'],
              data[individualKey]['image']);

          _productList.add(products);
        }
        _productList.length;
      });
    } catch (lastError) {
      _databaseState
          .error('Error actualizando datos productos: ' + lastError.toString());
    }

    notifyListeners();
  }
}
