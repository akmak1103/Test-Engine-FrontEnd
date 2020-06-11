import 'dart:convert' as json;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/groupModel.dart';
import '../utils/server.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class AddGroup extends StatefulWidget {
  @override
  _AddGroupState createState() => _AddGroupState();
  var userId;
}

class _AddGroupState extends State<AddGroup> {
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _descCtrl = TextEditingController();
  TextEditingController _mailidCtrl = TextEditingController();
  String msg = "";
  int _testid = 0;
  Map<String, dynamic> args;
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    widget.userId = args['userid'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Group'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              children: <Widget>[
                _createInputField("Group Name", _nameCtrl,1),
                _createInputField("Group Description", _descCtrl,1),
                _createTestDropdown(),
                _createInputField("Students", _mailidCtrl,8),
                SizedBox(
                  height: 15,
                ),
                Text(
                  msg,
                  style: TextStyle(color: Colors.red),
                ),
                FlatButton(
                  child: Text('Submit'),
                  onPressed: _addGroup,
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
  _createInputField(String hint, TextEditingController ctrl,int _minLines) {
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
  _addGroup() {
    Group group = new Group();
    group.name = _nameCtrl.text;
    group.description = _descCtrl.text;
    group.userId = widget.userId;
    group.testId = args['tests'][_testid]['id'];
    group.mailIds = _mailidCtrl.text.split(',');

    Future future = Server.createGroup(group);

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
        msg = 'Could not add test!';
        print(err);
      });
    });
  }

  _createTestDropdown()
  {
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

  _dropdownItems()
  {
    List<Map<String,dynamic>> dropdownItems = new List<Map<String,dynamic>>();
    List<dynamic> _tests = args['tests'];
    for (int i=0;i<_tests.length;i++)
      {
        Map<String,dynamic> item = {
          "display":_tests[i]['name'],
          "value":i
        };
        dropdownItems.add(item);
      }
    return dropdownItems;
  }
}