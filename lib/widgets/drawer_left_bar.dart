import 'package:flutter/material.dart';
import 'package:old_trustworthy/views/account_page.dart';
import 'package:old_trustworthy/views/address_page.dart';
// import 'package:old_trustworthy/views/administration_page.dart';
import 'package:old_trustworthy/views/product_loading_form.dart';
// import 'package:old_trustworthy/views/login_page.dart';

class DrawerLeftBar extends StatefulWidget {
  @override
  _DrawerLeftBarState createState() => _DrawerLeftBarState();
}

class _DrawerLeftBarState extends State<DrawerLeftBar> {
  // bool _loggenIn = false; //estado para saber si esta logueado o no

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(137, 172, 18, 1.0),
            ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14044.jpg'),
                    radius: 50.0,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Nombre Usuario',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                    ),
                  ),
                )
              ],
            ),
          ),
          //Acá voy agregando la lista con opciones
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Mis direcciones'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => MyAddressPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.receipt),
            title: Text('Mis pedidos'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Mi cuenta'),
            onTap: () {
              //Otra forma de navegar entre paginas
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MyLoginPage()),
              // );
              // if (_loggenIn) {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => MyAccountPage()),
              );
              // } else {
              //   Navigator.of(context).push(
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => MyLoginPage()),
              //   );
              // }
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('ADMINISTRADOR'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => ProductLoadingForm()),
              );
            },
          ),
        ],
      ),
    );
  }
}
