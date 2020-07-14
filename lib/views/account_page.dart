import 'package:flutter/material.dart';

import 'package:old_trustworthy/providers/login_provider.dart';
import 'package:provider/provider.dart';

class MyAccountPage extends StatefulWidget {
  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  @override
  Widget build(BuildContext context) {
    final LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);

    return Selector<LoginProvider, bool>(
      selector: (_, LoginProvider loginProvider) =>
          loginProvider.loginState.isLoggedIn,
      builder: (BuildContext context, bool isLoggedIn, _) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Mi cuenta'),
            ),
            body: Builder(
              builder: (context) => SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/vieja_confiable.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ListView(
                    children: <Widget>[
                      header(loginProvider),
                      Divider(
                          color: Colors.white, height: 50.0, thickness: 5.0),
                      myData(loginProvider),
                      Divider(
                          color: Colors.white, height: 50.0, thickness: 5.0),
                      settings(),
                      Divider(
                          color: Colors.white, height: 50.0, thickness: 5.0),
                      loginAccount(loginProvider, context),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }

  Widget header(LoginProvider loginProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(loginProvider
                  .accountUser.profilePicture.isEmpty
              ? 'https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14044.jpg'
              : loginProvider.accountUser.profilePicture),
          radius: 110.0,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            loginProvider.accountUser.nameUser.isEmpty
                ? 'Nombre del usuario'
                : loginProvider.accountUser.nameUser,
            style: TextStyle(fontSize: 35),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget myData(LoginProvider loginProvider) {
    TextEditingController _name = TextEditingController();
    TextEditingController _email = TextEditingController();
    TextEditingController _phone = TextEditingController();

    _name.text = loginProvider.accountUser.nameUser;
    _email.text = loginProvider.accountUser.emailUser;
    _phone.text = loginProvider.accountUser.phoneNumber;
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
            TextFormField(
              controller: _name,
              decoration: InputDecoration(
                labelText: 'Nombre Usuario',
              ),
            ),
            TextFormField(
              controller: _email,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _phone,
              decoration: InputDecoration(labelText: 'Telefono'),
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

  Widget loginAccount(LoginProvider loginProvider, BuildContext context) {
    if (loginProvider.loginState.isLoading) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
      );
    }
    if (loginProvider.loginState.hasError) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _showError(loginProvider.loginState.lastError, context);
      });
    }
    if (loginProvider.loginState.isLoggedIn) {
      return Container(
        margin: EdgeInsets.only(bottom: 20, left: 30, right: 30),
        decoration: BoxDecoration(
          color: Color.fromRGBO(47, 87, 44, 1.0),
        ),
        child: MaterialButton(
          child: Text(
            'Salir de Cuenta',
            style: TextStyle(color: Colors.white, fontSize: 25.0),
          ),
          onPressed: () {
            loginProvider.logout();
          },
        ),
      );
    } else {
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
          onPressed: () {
            loginProvider.login();
          },
        ),
      );
    }
  }

  void _showError(String lastError, context) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(lastError)));
  }

  // MaterialButton loginButton(LoginProvider loginProvider) {
  //   return MaterialButton(
  //     child: Text(
  //       'Ingresar Cuenta',
  //       style: TextStyle(color: Colors.white, fontSize: 25.0),
  //     ),
  //     onPressed: () {
  //       loginProvider.login();
  //     },
  //   );
  // }

  // MaterialButton logoutButton(LoginProvider loginProvider) {
  //   return MaterialButton(
  //     child: Text(
  //       'Salir de Cuenta',
  //       style: TextStyle(color: Colors.white, fontSize: 25.0),
  //     ),
  //     onPressed: () {
  //       loginProvider.logout();
  //     },
  //   );
}
// }

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
