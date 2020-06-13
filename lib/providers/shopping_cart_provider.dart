import 'package:flutter/cupertino.dart';
import 'package:old_trustworthy/models/product.dart';

class ShoppingCartProvider with ChangeNotifier {
  double _count = 0;

  List<Product> _cart = [];

  void sumCounter(String price) {
    _count += double.parse(price);
    notifyListeners();
  }

  void subtracCounter(String price) {
    _count -= double.parse(price);
    notifyListeners();
  }

  void resetCounter() {
    _count = 0;
  }

  List<Product> get getCart => _cart;
  double get getCounter => _count;
  int getProductCount(Product product) => product.getCount;

  void addCart(Product product) {
    for (var item in _cart) {
      if (product.image == item.image) {
        incrementCountProduct(item);
        notifyListeners();
        return;
      }
    }
    _cart.add(product);
    notifyListeners();
  }

  void incrementCountProduct(Product product) {
    for (var item in _cart) {
      if (item.image == product.image) {
        product.addCount();
      }
    }
    notifyListeners();
  }

  void subtractCountProduct(Product product) {
    var toRemove = [];
    for (var item in _cart) {
      if (item.image == product.image) {
        product.subtractCount();
        if (product.getCount == 0) {
          toRemove.add(product);
        }
      }
    }
    _cart.removeWhere((element) => toRemove.contains(element));
    notifyListeners();
  }
}
