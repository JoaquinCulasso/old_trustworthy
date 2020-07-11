import 'package:flutter/material.dart';

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
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/vieja_confiable.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buttom('Abrir Tienda', context,
                  '/massiveMessage'), //MassiveMessagePage()),
              _buttom('Agregar producto', context,
                  '/productLoading'), //ProductLoadingFormPage()),
              _buttom('Modificar/eliminar producto', context,
                  '/modifyDelete'), // ModifyDeleteProductPage()),
              _buttom('ABM categoria', context,
                  '/massiveMessage'), //ModifyDeleteProductPage()),
              _buttom('Mensaje masivo', context,
                  '/massiveMessage'), //MassiveMessagePage()),
            ],
          ),
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
      Navigator.of(context).pushNamed(route);
    },
  );
}
