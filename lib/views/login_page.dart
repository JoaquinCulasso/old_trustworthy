// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';


// import 'package:old_trustworthy/blocs/my_login_bloc/my_login_bloc.dart';
// import 'package:old_trustworthy/states/login_state.dart';
// import 'package:old_trustworthy/views/account_page.dart';

// class MyLoginPage extends StatefulWidget {
//   @override
//   _MyLoginPageState createState() => _MyLoginPageState();
// }

// class _MyLoginPageState extends State<MyLoginPage> {
//   Tuve q crear un contexto pq daba un error con el ancestro o algo así
//   MyLoginBloc _loginBloc = MyLoginBloc(login: SimpleLoginState());

//   TextEditingController emailController;
//   TextEditingController passwordController;

//   @override
//   void initState() {
//     super.initState();
//     emailController = TextEditingController();
//     passwordController = TextEditingController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login Cuenta'),
//       ),
//       body: SafeArea(
//         child: Stack(
//           children: <Widget>[
//             Container(
//               alignment: AlignmentDirectional.bottomCenter,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/images/vieja_confiable.png'),
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               child: Container(
//                 width: 200,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     FloatingActionButton(
//                       heroTag: 'gmail',
//                       backgroundColor: Color(0xff4285f4),
//                       child: Icon(FontAwesomeIcons.google),
//                       onPressed: () {},
//                     ),
//                     FloatingActionButton(
//                       heroTag: 'facebook',
//                       backgroundColor: Color(0xff3b5998),
//                       child: Icon(FontAwesomeIcons.facebookSquare),
//                       onPressed: () {},
//                     ),
//                     FloatingActionButton(
//                       heroTag: 'twitter',
//                       backgroundColor: Color(0xff00aced),
//                       child: Icon(FontAwesomeIcons.twitter),
//                       onPressed: () {},
//                     ),
//                     SizedBox(height: 420)
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   ),

//   child: Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.values[1],
//       children: <Widget>[
//         GoogleSignInButton(
//           text: 'Ingresar con Google',
//           onPressed: () {/* ... */},
//           darkMode: true,
//           borderRadius: 10.0,
//           // default: false
//         ),
//         TwitterSignInButton(
//           text: 'Ingresar con Twitter',
//           onPressed: () {},
//           borderRadius: 10.0,
//         ),
//         FacebookSignInButton(
//           text: 'Ingresar con Facebook',
//           onPressed: () {
//             // call authentication logic
//           },
//           borderRadius: 10.0,
//         ),
//         SizedBox(height: 60)
//       ],
//     ),
//   ),

//   GoogleSignInButton(
//     text: 'Ingresar con Google',
//     onPressed: () {/* ... */},
//     darkMode: true, // default: false
//   ),
//   TwitterSignInButton(
//     text: 'Ingresar con Twitter',
//     onPressed: () {},
//     borderRadius: 10.0,
//   ),
//   FacebookSignInButton(
//       text: 'Ingresar con Facebook',
//       onPressed: () {
//         // call authentication logic
//       }),
//   Padding(
//   padding: const EdgeInsets.all(16.0),
//   Padding(
//   padding: const EdgeInsets.all(20.0),
//   // child:
//   Form(
//     child: ListView(
//       children: <Widget>[
//   Padding(
//     padding: const EdgeInsets.symmetric(vertical: 20),
//     child: Image.asset(
//       'assets/images/vieja_confiable.png',
//       height: 200,
//     ),

//   ),
//         GoogleSignInButton(
//           text: 'Ingresar con Google',
//           onPressed: () {/* ... */},
//           darkMode: true, // default: false
//         ),
//         TwitterSignInButton(
//           text: 'Ingresar con Twitter',
//           onPressed: () {},
//           borderRadius: 10.0,
//         ),
//         FacebookSignInButton(
//             text: 'Ingresar con Facebook',
//             onPressed: () {
//               // call authentication logic
//             }),
//       ],
//     ),
//   // ),
//   ),
//   Container(
//     width: 200,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         FloatingActionButton(
//           heroTag: 'gmail',
//           child: Icon(FontAwesomeIcons.google),
//           onPressed: () {},
//         ),
//         FloatingActionButton(
//           heroTag: 'facebook',
//           child: Icon(FontAwesomeIcons.facebook),
//           onPressed: () {},
//         ),
//         FloatingActionButton(
//           heroTag: 'twitter',
//           child: Icon(FontAwesomeIcons.twitter),
//           onPressed: () {},
//         ),
//       ],
//     ),
//   ),
//   ],
//   ),
//   ),
//   child: BlocListener<MyLoginBloc, MyLoginState>(
//     // bloc: _loginBloc, // acá le paso el el contexto del bloc
//     listener: (context, state) {
//       if (state is ErrorState) {
//         _showError(context, state.message);
//       }
//       if (state is LoggedInState) {
//         Navigator.of(context).push(
//           MaterialPageRoute(
//               builder: (BuildContext context) => MyAccountPage()),
//         );
//       }
//     },
//     // child: BlocBuilder<MyLoginBloc, MyLoginState>(
//     //   // bloc: _loginBloc, // acá le paso el el contexto del bloc
//     //   builder: (BuildContext context, state) {
//     //     return Form(
//     //       child: Column(
//     //         children: <Widget>[
//     //           // TextFormField(
//               //   decoration: InputDecoration(labelText: 'email'),
//               //   controller: emailController,
//               // ),
//               // TextFormField(
//               //   decoration: InputDecoration(labelText: 'password'),
//               //   obscureText: true,
//               //   controller: passwordController,
//               // ),
//               // if (state is LogginInState)
//               //   Padding(
//               //     padding: const EdgeInsets.all(16.0),
//               //     child: CircularProgressIndicator(),
//               //   )
//               // else
//               //   RaisedButton(
//               //     child: Text("Ingresar"),
//               //     onPressed: _doLogin,
//               //   ),
//             // ],
//           // ),
//         // );
//       // },
//     // ),
//   ),
//   ),
//   );
// }

// void _doLogin() {
//   _loginBloc.add(DoLoginEvent(emailController.text, passwordController.text));
// }

// void _showError(BuildContext context, String message) {
//   Scaffold.of(context).showSnackBar(
//     SnackBar(content: Text(message)),
//   );
// }
// }
