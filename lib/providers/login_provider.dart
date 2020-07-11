import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:old_trustworthy/models/account.dart';
import 'package:old_trustworthy/state/login_state.dart';

class LoginProvider with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginState _loginState = LoginState();
  Account _account = Account();
  FirebaseUser _user;

  LoginState get loginState => this._loginState;
  Account get accountUser => this._account;

  LoginProvider() {
    isSignedIn();
  }

  FirebaseUser currentUser() => _user;

  void login() async {
    _loginState.loading();
    notifyListeners();

    try {
      _user = await signInWithGoogle();
      _loginState.login();
      _account.loginAccountUser(
          _user.displayName, _user.email, _user.photoUrl, _user.phoneNumber);
    } catch (lastError) {
      _loginState.error(lastError);
    }

    notifyListeners();
  }

  void logout() async {
    _googleSignIn.signOut();
    _auth.signOut();
    _loginState.logout();
    _account.logoutAccountUser();

    notifyListeners();
  }

  // SignInWithGoogle
  Future<FirebaseUser> signInWithGoogle() async {
    GoogleSignInAccount googleUser =
        await _googleSignIn.signIn().catchError((lastError) {
      _loginState.error(lastError);
    });

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }

  //logged in?
  void isSignedIn() async {
    _user = await _auth.currentUser();
    _loginState.isSignedIn(_user);

    notifyListeners();
  }
}
