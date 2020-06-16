import 'package:flutter/material.dart';

class MyAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi cuenta'),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/vieja_confiable.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: <Widget>[
              header(),
              Divider(color: Colors.white, height: 50.0, thickness: 5.0),
              myData(),
              Divider(color: Colors.white, height: 50.0, thickness: 5.0),
              settings(),
              Divider(color: Colors.white, height: 50.0, thickness: 5.0),
              loginAccount(),
            ],
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(
              'https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14044.jpg'),
          radius: 110.0,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Nombre del usuario',
            style: TextStyle(fontSize: 35),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget myData() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Mis datos',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            Divider(thickness: 2),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nombre',
              ),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Apellido'),
            )
          ],
        ),
      ),
    );
  }

  Widget settings() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Ajustes',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            Divider(thickness: 2),
            ListTile(
              title: Text('Configuracion'),
              onTap: () {},
            ),
            Divider(
              thickness: 2,
              height: 0,
            ),
            ListTile(
              title: Text('Cambiar email'),
              onTap: () {},
            ),
            Divider(thickness: 2, height: 0),
          ],
        ),
      ),
    );
  }

  Widget loginAccount() {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 30, right: 30),
      decoration: BoxDecoration(
        color: Color.fromRGBO(47, 87, 44, 1.0),
      ),
      child: MaterialButton(
        child: Text(
          'Ingresar Cuenta',
          style: TextStyle(color: Colors.white, fontSize: 25.0),
        ),
        onPressed: () {},
      ),
    );
  }
}

// class MyAccountPage extends StatefulWidget {
//   @override
//   _MyAccountPageState createState() => _MyAccountPageState();
// }

// class _MyAccountPageState extends State<MyAccountPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Mi cuenta'),
//       ),
//       body: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/vieja_confiable.png'),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: ListView(
//             children: <Widget>[
//               header(),
//               Divider(color: Colors.white, height: 50.0, thickness: 5.0),
//               myData(),
//               Divider(color: Colors.white, height: 50.0, thickness: 5.0),
//               settings(),
//               Divider(color: Colors.white, height: 50.0, thickness: 5.0),
//               loginAccount(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget header() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: <Widget>[
//         CircleAvatar(
//           backgroundImage: NetworkImage(
//               'https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14044.jpg'),
//           radius: 110.0,
//         ),
//         Text(
//           'Nombre del usuario',
//           style: TextStyle(fontSize: 35),
//         ),
//       ],
//     );
//   }

//   Widget myData() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Form(
//         child: Column(
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 Text(
//                   'Mis datos',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                 ),
//               ],
//             ),
//             Divider(thickness: 2),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Nombre',
//               ),
//             ),
//             TextField(
//               decoration: InputDecoration(labelText: 'Apellido'),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget settings() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Form(
//         child: Column(
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 Text(
//                   'Ajustes',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                 ),
//               ],
//             ),
//             Divider(thickness: 2),
//             ListTile(
//               title: Text('Configuracion'),
//               onTap: () {},
//             ),
//             Divider(
//               thickness: 2,
//               height: 0,
//             ),
//             ListTile(
//               title: Text('Cambiar email'),
//               onTap: () {},
//             ),
//             Divider(thickness: 2, height: 0),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget loginAccount() {
//     return Container(
//       margin: EdgeInsets.only(bottom: 20, left: 30, right: 30),
//       decoration: BoxDecoration(
//         color: Color.fromRGBO(47, 87, 44, 1.0),
//       ),
//       child: MaterialButton(
//         child: Text(
//           'Ingresar Cuenta',
//           style: TextStyle(color: Colors.white, fontSize: 25.0),
//         ),
//         onPressed: () {},
//       ),
//     );
//   }
// }
