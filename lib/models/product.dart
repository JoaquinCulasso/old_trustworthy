class Product {
  String _name, _price, _label, _unit, _image;

  Product(this._name, this._price, this._label, this._unit, this._image);

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

  //GETTERS

  String get name => this._name;
  String get price => this._price;
  String get label => this._label;
  String get unit => this._unit;
  String get image => this._image;
}
