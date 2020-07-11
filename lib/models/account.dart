class Account {
  String _nameUser = '';
  String _profilePicture = '';
  String _email = '';
  String _phoneNumber = '';

  void loginAccountUser(nameUser, email, profilePicture, phoneNumber) {
    this._nameUser = nameUser;
    this._email = email;
    this._phoneNumber = phoneNumber;
    this._profilePicture = profilePicture;
  }

  void logoutAccountUser() {
    this._nameUser = '';
    this._phoneNumber = '';
    this._profilePicture = '';
    this._email = '';
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
