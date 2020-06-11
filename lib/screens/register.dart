import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import '../utils/server.dart';
import '../models/registerModel.dart';
import 'dart:convert' as json;
import './loginScreen.dart';

import 'dashboard.dart';
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _userid = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _name = new TextEditingController();
  TextEditingController _address = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  String _role;
  String msg = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  _createInputField('Unique userid', _userid, 1),
                  _createPassInputField('Password', _password),
                  _createInputField('Name', _name, 1),
                  _createInputField('Adress', _address, 2),
                  _createInputField('Phone', _phone, 1),
                  _createInputField('Email', _email, 1),
                  _createRoleDropdown(),
                  SizedBox(height: 20,),
                  Text(msg),
                  FlatButton(
                    child: Text('Submit'),
                    onPressed: _registerUser,
                    padding: EdgeInsets.all(5),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                  SizedBox(height: 30,),
                  _buildLoginBtn()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _registerUser(){
    Register user = new Register();
    user.userid = _userid.text;
    user.role = _role;
    user.name = _name.text;
    user.password = _password.text;
    user.address = _address.text;
    user.phone = _phone.text;
    user.email = _email.text;

    print(user.toJson());
    Future future  = Server.register(user);

    future.then((response) {
      var jsonString = response.body;
      var object = json.jsonDecode(jsonString);
      if (object['msg'] != null) {
        setState(() {
          msg = object['msg'];
        });
      }
      else Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (c) => Dashboard(object)));
    }).catchError((err) {
      setState(() {
        msg = 'Could not register!';
        print(err);
      });
    });

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

  _createPassInputField(String hint, TextEditingController ctrl) {
    return Container(
      child: TextField(
        obscureText: true,
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

  _createRoleDropdown()
  {
    return DropDownFormField(
      titleText: 'Test',
      hintText: 'Role',
      value: _role,
      onChanged: (value) {
        setState(() {
          _role = value;
        });
      },
      dataSource: [
        {
          'display':'Teacher',
          'value':'Teacher'
        },
        {
          'display':'Student',
          'value':'Student'
        }
      ],
      textField: 'display',
      valueField: 'value',
    );
  }
  Widget _buildLoginBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => LoginScreen()));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Already have an Account? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Login',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
