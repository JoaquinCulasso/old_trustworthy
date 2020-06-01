import 'dart:async';

class SumPricesStream {
  double _count = 0;

  //singleton
  static SumPricesStream _instance = SumPricesStream();
  static SumPricesStream get instance => _instance;

  //declaro stream, broadcast pq esta en más de una vista
  final _controllerSumPrice = StreamController<double>.broadcast();

  //devuelvo el stream
  Stream<double> get streamCount => _controllerSumPrice.stream;

  //metodo para ir incrementado según precio del producto
  void incrementCount(String price) {
    _count += double.parse(price);
    _controllerSumPrice.add(_count);
  }

  void close() {
    _controllerSumPrice.close();
  }

  void resetCount() {
    _count = 0;
    _controllerSumPrice.add(_count);
  }
}
