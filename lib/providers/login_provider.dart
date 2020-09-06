import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:old_trustworthy/models/account.dart';

import 'package:old_trustworthy/state/login_state.dart';

class LoginProvider with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final LoginState _loginState = LoginState.intance; //singleton
  final Account _account = Account.instance; //singleton

  FirebaseUser _user;

  LoginState get loginState => this._loginState;
  Account get accountUser => this._account;

  LoginProvider() {
    isSignedIn();
  }

  FirebaseUser currentUser() => _user;

  void login(context) async {
    _loginState.loading();
    _progressAlertDialog(context, 'Logueando...');

    try {
      _user = await signInWithGoogle();
      _account.loginAccountUser(
          _user.displayName, _user.email, _user.photoUrl, _user.phoneNumber);
      _loginState.login();
    } catch (lastError) {
      _loginState.error(lastError.toString());
    }

    if (_loginState.isLoggedIn) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop();
      _snackBarError(context);
    }

    notifyListeners();
  }

  void logout(context) async {
    _loginState.loading();
    _progressAlertDialog(context, 'Saliendo de la cuenta');

    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      _loginState.logout();
      _account.logoutAccountUser();
      await Future.delayed(Duration(milliseconds: 3000));
    } catch (lastError) {
      _loginState.error(lastError.toString());
    }

    if (!_loginState.isLoggedIn) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop();
      _snackBarError(context);
    }

    notifyListeners();
  }

  // SignInWithGoogle
  Future<FirebaseUser> signInWithGoogle() async {
    GoogleSignInAccount _googleUser;
    GoogleSignInAuthentication _googleAuth;
    FirebaseUser _user;

    try {
      _googleUser = await _googleSignIn.signIn();
    } catch (lastError) {
      _loginState.error(lastError.toString());
    }

    try {
      _googleAuth = await _googleUser.authentication;
    } catch (lastError) {
      _loginState.error(lastError.toString());
    }

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: _googleAuth.accessToken,
      idToken: _googleAuth.idToken,
    );

    try {
      _user = (await _auth.signInWithCredential(credential)).user;
      print("signed in " + _user.displayName);
    } catch (lastError) {
      _loginState.error(lastError.toString());
    }

    return _user;
  }

  //logged in?
  void isSignedIn() async {
    try {
      _user = await _auth.currentUser();
      _loginState.isSignedIn(_user);
      _account.hasUserData();
    } catch (lastError) {
      _loginState.error(lastError.toString());
    }
    notifyListeners();
  }

  void _snackBarError(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Scaffold.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 3),
          content: Text(_loginState.lastError.toString())));
    });
  }

  Future<void> _progressAlertDialog(BuildContext context, String textTitle) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) {
        return Center(
          child: AlertDialog(
            title: Text(textTitle, style: TextStyle(fontSize: 25)),
            content: Center(
              heightFactor: 1.5,
              widthFactor: 1.5,
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
