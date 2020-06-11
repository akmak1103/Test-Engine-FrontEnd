class SubmitTest{
  String _userid;
  int _testid;
  List<dynamic> _answers;

  String get userid => _userid;

  set userid(String value) {
    _userid = value;
  }

  int get testid => _testid;

  List<dynamic> get answers => _answers;

  set answers(List<dynamic> value) {
    _answers = value;
  }

  set testid(int value) {
    _testid = value;
  }

  Map<String, dynamic> toJson() {
    return {
      "userid": _userid,
      "testid": _testid,
      "answers": _answers
    };
  }

}