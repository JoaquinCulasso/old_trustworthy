class Product {
  String _name, _price, _label, _unit, _image;
  int _count = 0;

  // Product(this._name, this._price, this._label, this._unit, this._image);
  Product(name, price, label, unit, image) {
    this._name = name;
    this._price = price;
    this._label = label;
    this._unit = unit;
    this._image = image;
    addCount();
  }

  //SETTERS
  set name(String name) {
    this._name = name;
  }

  set price(String price) {
    this._price = price;
  }

  set label(String label) {
    this._label = label;
  }

  set unit(String unit) {
    this._unit = unit;
  }

  set image(String image) {
    this._image = image;
  }

  void addCount() {
    this._count++;
  }

  void subtractCount() {
    this._count--;
  }

  //GETTERS
  String get name => this._name;
  String get price => this._price;
  String get label => this._label;
  String get unit => this._unit;
  String get image => this._image;
  int get getCount => this._count;
}
