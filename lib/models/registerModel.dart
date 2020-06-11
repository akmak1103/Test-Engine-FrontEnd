class Register{
  String _userid;
  String _password;
  String _name;
  String _address;
  String _phone;
  String _email;
  String _role;

  String get userid => _userid;

  set userid(String value) {
    _userid = value;
  }

  String get password => _password;

  String get role => _role;

  set role(String value) {
    _role = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  set password(String value) {
    _password = value;
  }

  Map<String, dynamic> toJson() {
    return {
      "userid": _userid,
      "password": _password,
      "name": _name,
      "address": _address,
      "phone": _phone,
      "email": _email,
      "role":_role
    };
  }

}