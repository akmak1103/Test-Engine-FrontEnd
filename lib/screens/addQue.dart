import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import '../models/questionModel.dart';
import '../utils/server.dart';
import 'dart:convert' as json;

class AddQuestion extends StatefulWidget {
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  Map<String, dynamic> args;
  int _testid = 0;
  int _op1Correct = 0;
  int _op2Correct = 0;
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _descCtrl = TextEditingController();
  TextEditingController _score = TextEditingController();
  TextEditingController _op1 = TextEditingController();
  TextEditingController _op2 = TextEditingController();
  String msg = "";
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Question to Test'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  _createInputField("Statement", _nameCtrl, 1),
                  _createInputField("Description", _descCtrl, 1),
                  _createNumberInputField("Score", _score),
                  _createTestDropdown(),
                  SizedBox(
                    height: 15,
                  ),
                  _createInputField("Option 1", _op1, 1),
                  _createOp1Dropdown(),
                  _createInputField("Option 2", _op2, 1),
                  _createOp2Dropdown(),
                  Text(
                    msg,
                    style: TextStyle(color: Colors.red),
                  ),
                  FlatButton(
                    child: Text('Submit'),
                    onPressed: _addQuestion,
                    padding: EdgeInsets.all(5),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _addQuestion() {
    Question que = new Question();
    que.name = _nameCtrl.text;
    que.description = _descCtrl.text;
    que.testId = args['tests'][_testid]['id'];
    que.score = int.tryParse(_score.text) ?? 20;
    que.answers = [
      {
        "name":_op1.text,
        "isCorrect":_op1Correct
      },
      {
        "name":_op2.text,
        "isCorrect":_op2Correct
      }
    ];
    print(que.toJson());

    Future future = Server.addQuestion(que);

    future.then((response) {
      var jsonString = response.body;
      var object = json.jsonDecode(jsonString);
      if (object['msg'] != null) {
        setState(() {
          msg = object['msg'];
        });
      }
    }).catchError((err) {
      setState(() {
        msg = 'Could not add question!';
        print(err);
      });
    });

  }

  _createOp1Dropdown()
  {
    return DropDownFormField(
      titleText: 'Test',
      hintText: 'Role',
      value: _op1Correct,
      onChanged: (value) {
        setState(() {
          _op1Correct = value;
        });
      },
      dataSource: [
        {
          'display':'is Correct',
          'value':1
        },
        {
          'display':'is Incorrect',
          'value':0
        }
      ],
      textField: 'display',
      valueField: 'value',
    );
  }


  _createOp2Dropdown()
  {
    return DropDownFormField(
      titleText: 'Test',
      hintText: 'Role',
      value: _op2Correct,
      onChanged: (value) {
        setState(() {
          _op2Correct = value;
        });
      },
      dataSource: [
        {
          'display':'is Correct',
          'value':1
        },
        {
          'display':'is Incorrect',
          'value':0
        }
      ],
      textField: 'display',
      valueField: 'value',
    );
  }


  _createInputField(String hint, TextEditingController ctrl, int _minLines) {
    return Container(
      child: TextField(
        controller: ctrl,
        minLines: _minLines,
        maxLines: 10,
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

  _createTestDropdown() {
    return DropDownFormField(
      titleText: 'Test',
      hintText: 'Please choose one test to assign',
      value: _testid,
      onChanged: (value) {
        setState(() {
          _testid = value;
        });
      },
      dataSource: _dropdownItems(),
      textField: 'display',
      valueField: 'value',
    );
  }

  _dropdownItems() {
    List<Map<String, dynamic>> dropdownItems = new List<Map<String, dynamic>>();
    List<dynamic> _tests = args['tests'];
    for (int i = 0; i < _tests.length; i++) {
      Map<String, dynamic> item = {"display": _tests[i]['name'], "value": i};
      dropdownItems.add(item);
    }
    return dropdownItems;
  }
}
