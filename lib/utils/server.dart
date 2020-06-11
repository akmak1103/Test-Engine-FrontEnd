import 'dart:convert' as json;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:testengine/models/questionModel.dart';
import '../models/registerModel.dart';
import '../models/submitTestModel.dart';
import '../models/groupModel.dart';

import '../models/testModel.dart';
import '../models/loginModel.dart';
import '../utils/urlConstants.dart';

class Server{
  static addTestToDB(Test test) async {
    var jsonString = json.jsonEncode(test.toJson());
    var map = await http.post(UrlConstants.addTest,headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonString);
    return map;
  }

  static login(User user) async {
    var jsonString = json.jsonEncode(user.toJson());
    var map = await http.post(UrlConstants.loginURL,headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonString);
    return map;
  }

  static register (Register user) async {
    var jsonString = json.jsonEncode(user.toJson());
    var map = await http.post(UrlConstants.register,headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonString);
    return map;
  }

  static fetchAllTests(String userid) async {
    var url = UrlConstants.allTest + '?userid=$userid';
    var map = await http.get(url,headers: {HttpHeaders.contentTypeHeader: "application/json"});
    return map;
  }

  static dashboard (String userid, String role) async {
    var url = UrlConstants.dashboard+'?userid=$userid&role=$role';
    var map = await http.get(url,headers:{HttpHeaders.contentTypeHeader: "application/json"});
    return map;
  }

  static createGroup (Group group) async {
    var jsonString = json.jsonEncode(group.toJson());
    var map = await http.post(UrlConstants.addGroup,headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonString);
    return map;
  }

  static checkEligibility (String userId,int testId) async {
    var url = UrlConstants.checkEligibility+'?userid=$userId&testid=$testId';
    var map = await http.get(url,headers:{HttpHeaders.contentTypeHeader: "application/json"});
    return map;
  }

  static getQuestions (int testId) async {
    var url = UrlConstants.startTest+'?testid='+testId.toString();
    var map = await http.get(url,headers:{HttpHeaders.contentTypeHeader: "application/json"});
    return map;
  }

  static evaluate (SubmitTest test) async {
    var jsonString = json.jsonEncode(test.toJson());
    var map = await http.post(UrlConstants.evaluateTest,headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonString);
    return map;
  }

  static addQuestion(Question que) async {
    var jsonString = json.jsonEncode(que.toJson());
    var map = await http.post(UrlConstants.addQuestion,headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonString);
    return map;
  }
}