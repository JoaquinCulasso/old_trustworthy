import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:old_trustworthy/blocs/my_login_bloc/my_login_bloc.dart';
import 'package:old_trustworthy/states/login_state.dart';
import 'package:old_trustworthy/views/account_page.dart';

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  //Tuve q crear un contexto pq daba un error con el ancestro o algo así
  MyLoginBloc _loginBloc = MyLoginBloc(login: SimpleLoginState());

  TextEditingController emailController;

  TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Cuenta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<MyLoginBloc, MyLoginState>(
          bloc: _loginBloc, // acá le paso el el contexto del bloc
          listener: (context, state) {
            if (state is ErrorState) {
              _showError(context, state.message);
            }
            if (state is LoggedInState) {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => MyAccountPage()),
              );
            }
          },
          child: BlocBuilder<MyLoginBloc, MyLoginState>(
            bloc: _loginBloc, // acá le paso el el contexto del bloc
            builder: (BuildContext context, state) {
              return Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'email'),
                      controller: emailController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'password'),
                      obscureText: true,
                      controller: passwordController,
                    ),
                    if (state is LogginInState)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      )
                    else
                      RaisedButton(
                        child: Text("Ingresar"),
                        onPressed: _doLogin,
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _doLogin() {
    _loginBloc.add(DoLoginEvent(emailController.text, passwordController.text));
  }

  void _showError(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
