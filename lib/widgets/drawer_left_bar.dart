import 'package:flutter/material.dart';
import 'package:old_trustworthy/views/login_page.dart';

class DrawerLeftBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
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
            onTap: () {},
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
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => MyLoginPage()),
              );
            },
          )
        ],
      ),
    );
  }
}
