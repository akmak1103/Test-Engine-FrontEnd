import 'dart:convert' as json;

import 'package:flutter/material.dart';
import '../models/testModel.dart';
import '../utils/server.dart';

class AddTest extends StatefulWidget {
  @override
  _AddTestState createState() => _AddTestState();
  var userId;
}

class _AddTestState extends State<AddTest> {

  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _descCtrl = TextEditingController();
  TextEditingController _attemptsCtrl = TextEditingController();
  TextEditingController _durationCtrl = TextEditingController();
  TextEditingController _scoreCtrl = TextEditingController();
  TextEditingController _createdByCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Map<String,String> args = ModalRoute.of(context).settings.arguments;
    widget.userId = args['userid'];
    _createdByCtrl.text = '${widget.userId}';
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Test'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              children: <Widget>[
                _createInputField("Test Name", _nameCtrl),
                _createInputField("Test Description", _descCtrl),
                _createNumberInputField("No. of Attempts", _attemptsCtrl),
                _createNumberInputField(
                    "Duration (No. of minutes", _durationCtrl),
                _createNumberInputField("Passing Score", _scoreCtrl),
                Container(
                  child: TextFormField(
                    enabled: false,
                    readOnly: true,
                    initialValue: _createdByCtrl.text,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintStyle: TextStyle(color: Colors.black38),
                      prefixIcon: Icon(Icons.input),
                    ),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  msg,
                  style: TextStyle(color: Colors.red),
                ),
                FlatButton(
                  child: Text('Submit'),
                  onPressed: _addTesToDB,
                  padding: EdgeInsets.all(5),
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _createNumberInputField(String hint, TextEditingController ctrl) {
    return Container(
      child: TextField(
        controller: ctrl,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: hint,
          alignLabelWithHint: true,
          hintStyle: TextStyle(color: Colors.black38),
          prefixIcon: Icon(Icons.input),
        ),
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
      ),
    );
  }

  _createInputField(String hint, TextEditingController ctrl) {
    return Container(
      child: TextField(
        controller: ctrl,
        decoration: InputDecoration(
          hintText: hint,
          alignLabelWithHint: true,
          hintStyle: TextStyle(color: Colors.black38),
          prefixIcon: Icon(Icons.input),
        ),
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
      ),
    );
  }

  String msg = '';

  _addTesToDB() {
    String testName = _nameCtrl.text;
    String desc = _descCtrl.text;
    int attempts = int.tryParse(_attemptsCtrl.text) ?? 1;
    int duration = int.tryParse(_durationCtrl.text) ?? 30;
    int score = int.tryParse(_scoreCtrl.text) ?? 20;
    String createdBy = _createdByCtrl.text;

    Test test = new Test();
    test.testName = testName;
    test.attempts = attempts;
    test.createdBy = createdBy;
    test.desc = desc;
    test.duration = duration;
    test.score = score;

    Future future = Server.addTestToDB(test);

    future.then((response) {
      var jsonString = response.body;
      var object = json.jsonDecode(jsonString);
      if (object['msg']!=null) {
        setState(() {
          msg = object['msg'];
        });
      }
    }).catchError((err) {
      setState(() {
        msg = 'Could not add test!';
        print(err);
      });
    });
  }
}
