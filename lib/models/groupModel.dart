class Group{
  String _name;
  String _description;
  String _userId;
  int _testId;
  List<String> _mailIds;
  String get name => _name;

  int get testId => _testId;

  set testId(int value) {
    _testId = value;
  }

  set name(String value) {
    _name = value;
  }

  String get description => _description;

  String get userId => _userId;

  set userId(String value) {
    _userId = value;
  }

  set description(String value) {
    _description = value;
  }

  Map<String, dynamic> toJson() {
    return {
      "name": _name,
      "descr": _description,
      "userid": _userId,
      "testid": _testId,
      "mailids": _mailIds
    };
  }

  List<String> get mailIds => _mailIds;

  set mailIds(List<String> value) {
    _mailIds = value;
  }
}