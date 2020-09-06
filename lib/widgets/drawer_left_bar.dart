import 'package:flutter/material.dart';

//provider
import 'package:provider/provider.dart';
import 'package:old_trustworthy/providers/login_provider.dart';

//views
import 'package:old_trustworthy/views/account_page.dart';
import 'package:old_trustworthy/views/address_page.dart';
import 'package:old_trustworthy/views/administration_page.dart';

class DrawerLeftBar extends StatelessWidget {
  // bool _loggenIn = false; //estado para saber si esta logueado o no
  final String usuario = 'joaquin';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.all(0.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(47, 87, 44, 1.0),
            ),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            context.select((LoginProvider loginProvider) =>
                                loginProvider.accountUser.profilePicture.isEmpty
                                    ? 'https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14044.jpg'
                                    : loginProvider.accountUser.profilePicture),
                          ),
                          radius: 50.0,
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            context.select(
                              (LoginProvider loginProvider) =>
                                  loginProvider.accountUser.nameUser.isEmpty
                                      ? 'Nombre de Usuario'
                                      : loginProvider.accountUser.nameUser,
                            ),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          //Acá voy agregando la lista con opciones
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
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
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => MyAccountPage()),
              );
            },
          ),
          if (usuario == "joaquin")
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('ADMINISTRADOR'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          MyAdministrationPage()),
                );
              },
            ),
        ],
      ),
    );
  }
}
