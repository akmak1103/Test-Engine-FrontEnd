import 'package:flutter/material.dart';
import 'package:testengine/models/submitTestModel.dart';
import '../utils/server.dart';
import 'dart:convert' as json;

class AttemptTest extends StatefulWidget {
  @override
  _AttemptTestState createState() => _AttemptTestState();
  var questions;
}

class _AttemptTestState extends State<AttemptTest> {
  static List<dynamic> _selectedAnswers;
  static List<dynamic> _selectedAnsName;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    widget.questions = args['questions'];
    int size = args['size'];
    _selectedAnswers = new List<dynamic>(size);
    _selectedAnsName = new List<dynamic>(size);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Test'),
          backgroundColor: Colors.blueGrey.shade900,
        ),
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.questions.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: Container(
                          padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
                          width: MediaQuery.of(context).size.width * 0.81,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Text(
                                      'Question No.' + (index + 1).toString()),
                                ),
                                Text(
                                  'Score: ' +
                                      widget.questions[index]['score']
                                          .toString(),
                                  style: TextStyle(fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 15),
                                  child: Text(
                                    widget.questions[index]['name'],
                                    style: TextStyle(fontSize: 25),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Text(
                                    'bh' + widget.questions[index]['descr'],
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Column(
                                  children: _options(
                                      widget.questions[index]['qid'],
                                      widget.questions[index]['answers'],
                                      index),
                                )
                              ])),
                    );
                  }),
            ),
          ),
          MaterialButton(
            onPressed: () {
              _submitTest(args['userid'], args['testid']);
            },
            color: Colors.blue,
            child: Text('Submit'),
            textColor: Colors.white,
          )
        ]),
      ),
    );
  }

  _options(int qid, List<dynamic> options, int index) {
    List<Widget> radioButtons = List<Widget>();
    for (int i = 0; i < options.length; i++) {
      RadioListTile radioListTile = RadioListTile(
        activeColor: Colors.blue,
        onChanged: (value) {
          _selectedAnswers[index] = value;
          _selectedAnsName[index] = options[i]['name'];
        },
        title: Text(options[i]['name']),
        groupValue: _selectedAnswers[index],
        value: {"qid": qid, "aid": options[i]['aid']},
      );
      radioButtons.add(radioListTile);
    }
    return radioButtons;
  }

  _submitTest(String userid, int testid) {
    print(_selectedAnswers);
    SubmitTest test = new SubmitTest();
    test.userid = userid;
    test.testid = testid;
    test.answers = _selectedAnswers;

    Future future = Server.evaluate(test);
    future.then((response) {
      var jsonString = response.body;
      var object = json.jsonDecode(jsonString);
      Navigator.pushReplacementNamed(context, '/score',
          arguments: {'data': object, 'selectedAns': _selectedAnsName});
    }).catchError((err) {
      print(err);
    });
  }
}
