import 'package:flutter/cupertino.dart';
import 'package:old_trustworthy/models/product.dart';

class ShoppingCartProvider with ChangeNotifier {
  double _count = 0;
  List<Product> _cart = [];

  get getCounter => _count;

  void sumCounter(String price) {
    _count += double.parse(price);
    notifyListeners();
  }

  void resetCounter() {
    _count = 0;
  }

  List<Product> get getCart => _cart;

  void addCart(Product product) {
    _cart.add(product);
    notifyListeners();
  }
}
