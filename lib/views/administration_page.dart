import 'package:flutter/material.dart';
import 'package:old_trustworthy/views/massive_message_page.dart';
import 'package:old_trustworthy/views/modify_delete_product_page.dart';
import 'package:old_trustworthy/views/product_loading_form_page.dart';

class MyAdministrationPage extends StatefulWidget {
  @override
  _MyAdministrationPageState createState() => _MyAdministrationPageState();
}

class _MyAdministrationPageState extends State<MyAdministrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administración'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buttom('Agregar Producto', context, ProductLoadingFormPage()),
            _buttom('Modificar o eliminar Producto', context,
                ModifyDeleteProductPage()),
            _buttom('Mensaje masivo', context, MassiveMessagePage()),
          ],
        ),
      ),
    );
  }
}

Widget _buttom(String title, context, route) {
  return MaterialButton(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22.0,
        ),
      ),
    ),
    shape: StadiumBorder(),
    textColor: Colors.white,
    color: Color.fromRGBO(47, 87, 44, 1.0),
    onPressed: () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) => route));
    },
  );
}
