class Question{
  String _name;
  String _description;
  int _testId;
  int _score;
  List<dynamic> _answers;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get description => _description;

  List<dynamic> get answers => _answers;

  set answers(List<dynamic> value) {
    _answers = value;
  }

  int get score => _score;

  set score(int value) {
    _score = value;
  }

  int get testId => _testId;

  set testId(int value) {
    _testId = value;
  }

  set description(String value) {
    _description = value;
  }

  Map<String, dynamic> toJson() {
    return {
      "testid": _testId,
      "name": _name,
      "answers": _answers,
      "descr":_description,
      "score":_score
    };
  }
}