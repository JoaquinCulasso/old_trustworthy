import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  Map<String, bool> _categories = {
    'Carnes': false,
    'Congelados': false,
    'Frutas': false,
    'Lacteos fiambres': false,
    'Verduras': false,
    'Limpieza': false,
    'Higiene personal': false,
    'Almacen': false,
  };

  String _categoryActive = '';
  bool _selected = false;

  Map<String, bool> get categoriesMap => this._categories;
  String get categoryActive => _categoryActive;
  bool get selected => this._selected;

  void changeValueCategory() {
    _categories.forEach((key, value) {
      if (value == true) {
        if (_categoryActive == key) {
          _categoryActive = '';
        } else {
          _categoryActive = key;
        }
      }
    });
    isSelected();
    notifyListeners();
  }

  void selectedCategory(String categoryName) {
    _categories.forEach((key, value) {
      if (key == categoryName) {
        _categories.update(key, (value) => true);
      } else {
        _categories.update(key, (value) => false);
      }
    });
    changeValueCategory();
    isSelected();
    notifyListeners();
  }

  void isSelected() {
    if (_categoryActive.isEmpty) {
      _selected = false;
    } else {
      _selected = true;
    }
    notifyListeners();
  }
}
