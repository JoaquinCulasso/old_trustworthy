import 'package:old_trustworthy/configs/preference.dart';

class LoginState {
  //singleton
  LoginState._instance();
  static final LoginState intance = LoginState._instance();

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasError = false;
  bool get hasError => _hasError;

  String _lastError;
  String get lastError => this._lastError;

  void loading() {
    _isLoading = true;
    _isLoggedIn = false;
    _hasError = false;
  }

  void login() {
    _hasError = false;
    _isLoading = false;
    _isLoggedIn = true;
    SharedPreferensesManager.setBool('isLoggedIn', true);
  }

  void logout() {
    _hasError = false;
    _isLoading = false;
    _isLoggedIn = false;
    SharedPreferensesManager.clear();
  }

  void error(lastError) {
    _hasError = true;
    _isLoading = false;
    _isLoggedIn = false;
    _lastError = lastError;
  }

  void isSignedIn(user) {
    if (SharedPreferensesManager.getBool('isLoggedIn')) {
      _isLoading = false;
      _isLoggedIn = user != null;
    } else {
      _isLoading = false;
    }
  }
}
