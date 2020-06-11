class User{
  String _userId;
  String _password;

  String get userId => _userId;

  set userId(String value) {
    _userId = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  Map<String, dynamic> toJson() {
    return {
      "email": _userId,
      "password": _password
    };
  }

}