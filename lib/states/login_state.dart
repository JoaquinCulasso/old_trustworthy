abstract class LoginState {
  Future<String> login(String email, String password);
  Future<String> logout();
}

class LoginException implements Exception {}

class SimpleLoginState extends LoginState {
  @override
  Future<String> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));

    if (email != 'demo@demo.com' || password != '123456') {
      throw LoginException();
    }
    return 'un token';
  }

  @override
  Future<String> logout() async {
    return '';
  }
}
