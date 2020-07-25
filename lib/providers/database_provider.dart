import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:old_trustworthy/models/product.dart';
import 'package:old_trustworthy/state/database_state.dart';

class DatabaseProvider with ChangeNotifier {
  //referende Storage
  final StorageReference _imageRef =
      FirebaseStorage.instance.ref().child("Vieja_Confiable");

  //reference Database
  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.reference().child("Vieja_Confiable");

  //database state
  final DatabaseState _databaseState = DatabaseState();

  DatabaseState get databaseState => this._databaseState;

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
    notifyListeners();
  }

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

    //ver la navegacion
    _databaseState.isLoaded
        ? Navigator.of(context).pushReplacementNamed('/modifyDelete')
        : WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Scaffold.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 8),
                content: Text(_databaseState.lastError)));
          });
    notifyListeners();
  }

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

  //load image storage
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

  //load data
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

    // _databaseRef
    //     .orderByChild('image')
    //     .equalTo(_url)
    //     .onChildAdded
    //     .listen((event) {

    //   FirebaseDatabase.instance
    //       .reference()
    //       .child('Vieja_Confiable')
    //       .child(event.snapshot.key)
    //       .update(data)
    //       .then((value) => value)
    //       .whenComplete(() => _databaseState.loaded())
    //       .catchError((lastError) => _databaseState.error(
    //           'Error actualizando datos productos: ' + lastError.toString()));
    // });
  }
}
