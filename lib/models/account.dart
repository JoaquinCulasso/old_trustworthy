import 'package:old_trustworthy/configs/preference.dart';

class Account {
  //singleton
  Account._instance();
  static final Account instance = Account._instance();

  String _nameUser = '';
  String _profilePicture = '';
  String _email = '';
  String _phoneNumber = '';

  set nameUser(name) => this.nameUser = name;
  set profilePicture(profilePicture) => this._profilePicture = profilePicture;
  set email(email) => this._email = email;
  set phoneNumber(phoneNumber) => this._phoneNumber = phoneNumber;

  void loginAccountUser(nameUser, email, profilePicture, phoneNumber) async {
    this._nameUser = nameUser;
    this._email = email;
    this._phoneNumber = phoneNumber;
    this._profilePicture = profilePicture;
    SharedPreferensesManager.setString('name', nameUser);
    SharedPreferensesManager.setString('email', email);
    SharedPreferensesManager.setString('phoneNumber', phoneNumber);
    SharedPreferensesManager.setString('profilePicture', profilePicture);
  }

  void hasUserData() {
    _nameUser = SharedPreferensesManager.getString('name');
    _email = SharedPreferensesManager.getString('email');
    _phoneNumber = SharedPreferensesManager.getString('phoneNumber');
    _profilePicture = SharedPreferensesManager.getString('profilePicture');
  }

  void logoutAccountUser() {
    this._nameUser = '';
    this._phoneNumber = '';
    this._profilePicture = '';
    this._email = '';
    SharedPreferensesManager.clear();
  }

  String get nameUser => this._nameUser;
  String get profilePicture => this._profilePicture;
  String get phoneNumber => this._phoneNumber;
  String get emailUser => this._email;

  @override
  String toString() {
    return '''LoginState{
      _nameUser: $_nameUser,
      _profilePicture: $_profilePicture,
      _phoneNumber: $_phoneNumber,
      _email: $_email,
    }''';
  }
}
