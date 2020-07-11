import 'package:shared_preferences/shared_preferences.dart';

class LoginState {
  SharedPreferences _preferences;

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
    _preferences.setBool('isLoggedIn', true);
  }

  void logout() {
    _hasError = false;
    _isLoading = false;
    _isLoggedIn = false;
    _preferences.clear();
  }

  void error(lastError) {
    _hasError = true;
    _isLoading = false;
    _isLoggedIn = false;
    _lastError = lastError.toString();
  }

  void isSignedIn(user) async {
    _preferences = await SharedPreferences.getInstance();
    if (_preferences.containsKey('isLoggedIn')) {
      _isLoading = false;
      _isLoggedIn = user != null;
    } else {
      _isLoading = false;
    }
  }

  @override
  String toString() {
    return '''LoginState{
      _isLoggedIn: $_isLoggedIn,
      _isLoading: $_isLoading,
      _hasError: $_hasError,
    }''';
  }
}
