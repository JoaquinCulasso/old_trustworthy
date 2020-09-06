import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:old_trustworthy/providers/login_provider.dart';

class MyAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  Header(),
                  Divider(color: Colors.white, height: 50.0, thickness: 5.0),
                  MyData(),
                  Divider(color: Colors.white, height: 50.0, thickness: 5.0),
                  Settings(),
                  Divider(color: Colors.white, height: 50.0, thickness: 5.0),
                  LoginAccountButton(),
                ],
              ),
            ),
          ),
        ));
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    // final loginProvider = context.watch<LoginProvider>(); // other form with provider

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
}

class MyData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

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
}

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}

class LoginAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    if (loginProvider.loginState.isLoggedIn) {
      return Container(
        margin: EdgeInsets.only(bottom: 20, left: 30, right: 30),
        decoration: BoxDecoration(
          color: Color.fromRGBO(47, 87, 44, 1.0),
        ),
        child: MaterialButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Salir de Cuenta Gmail',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
              Image.asset(
                'assets/images/google_icon2.png',
                height: 40.0,
                alignment: Alignment.centerRight,
              ),
            ],
          ),
          onPressed: () {
            loginProvider.logout(context);
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Ingresar Cuenta Gmail',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
              Image.asset(
                'assets/images/google_icon2.png',
                height: 40.0,
                alignment: Alignment.centerRight,
              ),
            ],
          ),
          onPressed: () {
            loginProvider.login(context);
          },
        ),
      );
    }
  }
}
