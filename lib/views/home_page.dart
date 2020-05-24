import 'package:flutter/material.dart';

import 'package:old_trustworthy/widgets/products_cart.dart';
import 'package:old_trustworthy/widgets/drawer_left_bar.dart';
import 'package:old_trustworthy/widgets/product_list.dart';
import 'package:old_trustworthy/widgets/pruduct_title.dart';
import 'package:old_trustworthy/widgets/selection_labels.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Vieja Confiable',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/vieja_confiable.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SelectionLabels(),
                  Divider(color: Colors.black, thickness: 5.0, height: 50.0),
                  ProductTitle(title: 'Verduras'),
                  ProductList(), //Verduras
                  Divider(color: Colors.black, thickness: 5.0, height: 50.0),
                  ProductTitle(title: 'Frutas'),
                  ProductList(), //Frutas
                  Divider(color: Colors.black, thickness: 5.0, height: 50.0),
                  ProductTitle(title: 'Carnes'),
                  ProductList(), //Carnes
                  Divider(color: Colors.black, thickness: 5.0, height: 50.0),
                  ProductTitle(title: 'Congelados'),
                  ProductList(), //Congelados
                  Divider(color: Colors.black, thickness: 5.0, height: 50.0),
                  ProductTitle(title: 'Higiene personal'),
                  ProductList(), //Higiene personal
                  Divider(color: Colors.black, thickness: 5.0, height: 50.0),
                  ProductTitle(title: 'Limpieza'),
                  ProductList(), //Limpieza
                  Divider(color: Colors.black, thickness: 5.0, height: 50.0),
                  ProductTitle(title: 'Fiambres'),
                  ProductList(), //Fiambres
                  Divider(color: Colors.white, thickness: 5.0, height: 50.0),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: DrawerLeftBar(),
      bottomNavigationBar: ProductsCart(),
    );
  }
}

// Widget selectionLabels() {
//   return Column(
//     children: <Widget>[
//       Row(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           _bottonAction(OldTrustworthyIcons.carnes, () {}),
//           _bottonAction(OldTrustworthyIcons.congelados, () {}),
//           _bottonAction(OldTrustworthyIcons.frutas, () {}),
//           _bottonAction(OldTrustworthyIcons.higiene_personal, () {}),
//         ],
//       ),
//       Row(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           _bottonAction(OldTrustworthyIcons.lacteos_fiambres, () {}),
//           _bottonAction(OldTrustworthyIcons.limpieza, () {}),
//           _bottonAction(OldTrustworthyIcons.verduras, () {}),
//         ],
//       ),
//     ],
//   );
// }

// Widget _bottonAction(IconData icon, Function callback) {
//   return InkWell(
//     borderRadius: BorderRadius.circular(25),
//     splashColor: Colors.greenAccent,
//     child: Padding(
//       padding: EdgeInsets.all(15.0),
//       child: Icon(icon),
//     ),
//     onTap: callback,
//   );
// }

// Widget oneList() {
//   return Container(
//     height: 175.0,
//     // color: Colors.greenAccent,
//     child: ListView(
//       scrollDirection: Axis.horizontal,
//       children: <Widget>[
//         _item(AssetImage('assets/products/manzana.jpg'), 'MANZANA', 'VERDURAS',
//             60.56, 'KG'),
//         _item(AssetImage('assets/products/zanahoria.jpg'), 'ZANAHORIA',
//             'VERDURAS', 35, 'KG'),
//         _item(AssetImage('assets/products/limon.jpg'), 'LIMON', 'VERDURAS',
//             20.30, 'KG'),
//         _item(AssetImage('assets/products/uva.jpg'), 'UVA', 'VERDURAS', 60.56,
//             'KG'),
//       ],
//     ),
//   );
// }

// Widget _item(
//     AssetImage image, String name, String label, double price, String unit) {
//   return Container(
//     width: 175.0,
//     decoration: BoxDecoration(
//       border: Border.all(color: Colors.black, width: 3),
//       borderRadius: BorderRadius.circular(20),
//       image: DecorationImage(
//           image: image, //AssetImage('assets/products/limon.jpg'),
//           fit: BoxFit.contain,
//           alignment: Alignment.topCenter),
//     ),
//     child: Column(
//       children: <Widget>[
//         Padding(
//           padding: EdgeInsets.only(top: 130),
//           child: Text(
//             name, //'Limon',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         Text(
//           price.toString() + ' x ' + unit, //'Precio',
//         ),
//       ],
//     ),
//   );
// }

// Widget _item(BuildContext context, DocumentSnapshot data) {
//   return Container(
//     width: 175.0,
//     decoration: BoxDecoration(
//       border: Border.all(color: Colors.black, width: 3),
//       borderRadius: BorderRadius.circular(20),
//       // image: DecorationImage(
//       //     image: image, //AssetImage('assets/products/limon.jpg'),
//       //     fit: BoxFit.contain,
//       //     alignment: Alignment.topCenter),
//     ),
//     child: Column(
//       children: <Widget>[
//         Padding(
//           padding: EdgeInsets.only(top: 130),
//           child: Text(
//             data['Name'], //'Limon',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         Text(
//           data['Price'].toString() + ' x ' + data['Unit'], //'Precio',
//         ),
//       ],
//     ),
//   );
// }

// Widget _buildItem(BuildContext context) {
//   return StreamBuilder<QuerySnapshot>(
//       stream: Firestore.instance.collection('products').snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return LinearProgressIndicator();
//         print(snapshot.data.documents);
//         return _buildList(context, snapshot.data.documents);
//       });
// }

// Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
//   return Column(
//     children: snapshot.map((data) => _item(context, data)).toList(),
//   );
// }

// Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
//   print(data['Unit']);
//   return Container();
// }
