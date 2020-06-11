class Test {
  String _testName;
  String _desc;
  String _createdBy;
  int _score;
  int _duration;

  String get testName => _testName;

  set testName(String value) => _testName = value;

  int _attempts;

  String get desc => _desc;

  set desc(String value) {
    _desc = value;
  }

  String get createdBy => _createdBy;

  set createdBy(String value) {
    _createdBy = value;
  }

  int get score => _score;

  set score(int value) {
    _score = value;
  }

  int get duration => _duration;

  set duration(int value) {
    _duration = value;
  }

  int get attempts => _attempts;

  set attempts(int value) {
    _attempts = value;
  }

  Map<String, dynamic> toJson() {
    return {
      "name": _testName,
      "descr": _desc,
      "duration": _duration,
      "passingScore": _score,
      "createdBy": _createdBy,
      "noOfAttempts": _attempts
    };
  }
}
