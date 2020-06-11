class UrlConstants {
  static final String baseURL = "192.168.1.8:8080";

  static final String loginURL = 'http://$baseURL/test_engine/login';

  static final String register = 'http://$baseURL/test_engine/signup';

  static final String allTest = "http://$baseURL/test_engine/alltests";

  static final String allStudents = "http://$baseURL/test_engine/allstudents";

  static final String addTest = "http://$baseURL/test_engine/addtest";

  static final String addQuestion = "http://$baseURL/test_engine/addquestion";

  static final String mapTestAndQuestion =
      "http://$baseURL/test_engine/mapquestions";

  static final String getQuestionByID =
      "http://$baseURL/test_engine/getquestion"; //requires param qid

  static final String getQuestionsByTestID =
      "http://$baseURL/test_engine/gettestquestion"; //requires param testid

  static final String dashboard =
      "http://$baseURL/test_engine/dashboard"; //requires param userid and role

  static final String addGroup = "http://$baseURL/test_engine/createGroup";

  static final String checkEligibility =
      "http://$baseURL/test_engine/checkEligibility"; //requires param userid and testid

  static final String startTest =
      "http://$baseURL/test_engine/gettestquestion"; //requires param testid

  static final String evaluateTest = "http://$baseURL/test_engine/evaluate";

}
