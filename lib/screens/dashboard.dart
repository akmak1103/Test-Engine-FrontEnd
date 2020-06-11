
import 'dart:math';

import 'package:flutter/material.dart';
import '../utils/server.dart';
import 'dart:convert' as json;
import 'dart:async';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Dashboard extends StatefulWidget {
  var user;
  var dashboard;

  Dashboard(user) {
    this.user = user;
  }

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  _fetchDashbaordData() {
    Future future =
        Server.dashboard(widget.user['userid'], widget.user['roleName']);
    future.then((response) {
      var jsonString = response.body;
      var object = json.jsonDecode(jsonString);
      widget.dashboard = object;
    }).catchError((err) {
      print("Some error occurred !!!!!!");
    });
    return future;
  }

  @override
  Widget build(BuildContext context) {
    var data = _fetchDashbaordData();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          elevation: 5,
          leading: Icon(Icons.menu),
          title: Text('Dashboard'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {});
              },
            )
          ],
        ),
        body: _displayDashboard(data, widget.user['roleName']),
//        drawer: Drawer(
//          child: ListView(
//            children: <Widget>[
//              _createHeader(),
//              Column(
//                mainAxisAlignment: MainAxisAlignment.end,
//                mainAxisSize: MainAxisSize.max,
//                children: <Widget>[
//                  ListView.builder(
//                    shrinkWrap: true,
//                    itemCount: (widget.user['rights'].length),
//                    itemBuilder: (context, index) {
//                      return ListTile(
//                        title: Text('${widget.user['rights'][index]['name']}'),
//                        onTap: () {
//                          Navigator.pushNamed(
//                              context, '${widget.user['rights'][index]['url']}',
//                              arguments: {
//                                'userid': '${widget.user['userid']}',
//                              });
//                        },
//                      );
//                    },
//                  ),
//                ],
//              ),
//            ],
//          ),
//        ),
        floatingActionButton: _floatingButton(widget.user['roleName']),
      ),
    );
  }

  _floatingButton(String role) {
    if (role == 'Teacher')
      return SpeedDial(
        marginRight: 20,
        marginBottom: 24,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        tooltip: 'Speed Dial',
        backgroundColor: Colors.blueGrey.shade900,
        foregroundColor: Colors.white,
        elevation: 4.0,
        shape: CircleBorder(),
        children: _speedDialList(),
      );
//    else
//      return FloatingActionButton(
//        onPressed: () {
//        },
//        elevation: 5,
//        backgroundColor: Colors.blue,
//        foregroundColor: Colors.white,
//        child: Icon(Icons.info),
//      );
  }

  _speedDialList() {
    List<SpeedDialChild> speedDials = List<SpeedDialChild>();
    for (var i = 0; i < widget.user['rights'].length; i++) {
      speedDials.add(SpeedDialChild(
        child: Icon(Icons.playlist_add),
        backgroundColor: Colors.blueGrey.shade900,
        label: widget.user['rights'][i]['name'],
        labelStyle: TextStyle(fontSize: 18.0),
        onTap: () {
          if (widget.user['rights'][i]['url'] == '/groups') {
            Navigator.pushNamed(context, '${widget.user['rights'][i]['url']}',
                arguments: {
                  'userid': '${widget.user['userid']}',
                  'tests': widget.dashboard['tests']
                });
          } else if (widget.user['rights'][i]['url'] == '/questions') {
            Navigator.pushNamed(context, '${widget.user['rights'][i]['url']}',
                arguments: {'tests': widget.dashboard['tests']});
          } else
            Navigator.pushNamed(context, '${widget.user['rights'][i]['url']}',
                arguments: {
                  'userid': '${widget.user['userid']}',
                });
        },
      ));
    }
    return speedDials;
  }

  _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(color: Colors.blue),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              child: Text(
                '${widget.user['name'][0]}',
                style: TextStyle(fontSize: 50),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              '${widget.user['name']}  |  ${widget.user['roleName']}',
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
          ],
        ));
  }

  _displayDashboard(var data, String role) {
    if (role == 'Teacher')
      return _teacherDashBoard(data);
    else if (role == 'Student') return _studentDashBoard(data);
  }

  _teacherDashBoard(var data) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: MediaQuery
                .of(context)
                .size.height * 0.02,
          ),
          Center(
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size.width * 0.90,
              height: MediaQuery
                  .of(context)
                  .size.height * 0.15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.lightBlueAccent.shade700),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: Text(
                        '${widget.user['name'][0]}',
                        style: TextStyle(fontSize: 45,color: Colors.blueGrey[900]),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 27,
                        ),
                        Text(
                          widget.user['name'].toString().split(" ")[0],
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          widget.user['roleName'],
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w300,color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 20, 5, 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Email: '+widget.user['email'],style: TextStyle(color: Colors.white),),
                        Text('Contact: '+widget.user['phone'].toString(),style: TextStyle(color: Colors.white)),
                        Text('Address: '+widget.user['address'],style: TextStyle(color: Colors.white))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.02,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(17, 0, 0, 0),
            child: Text(
              'Tests:',
              style: TextStyle(fontSize: 25,fontStyle: FontStyle.italic,fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.02,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.hasData && widget.dashboard != null) {
                  if (widget.dashboard['tests'].length != 0)
                    return _testCards(widget.dashboard['tests']);
                  else
                    return Text('Create a new test today!');
                } else
                  return CircularProgressIndicator();
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.03,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(17, 0 , 17, 0),
            child: Text(
              'Groups:',
              style: TextStyle(fontSize: 25,fontStyle: FontStyle.italic,fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.02,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(17, 0 , 17, 0),
            child: FutureBuilder(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.hasData && widget.dashboard != null) {
                  if (widget.dashboard['groups'].length != 0)
                    return _groupCards(widget.dashboard['groups']);
                  else
                    return Text('Create a new group today!');
                } else
                  return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }

  _testCards(var tests) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: tests.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              color: _randomColors[Random().nextInt(_randomColors.length)],
              child: Container(
                  padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
                  width: 200,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          tests[index]['name'],
                          style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Description: ' + tests[index]['descr'],
                          style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic,color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Attempts Allowed: ' +
                              tests[index]['noOfAttempts'].toString() +
                              '\nDuration:  ' +
                              tests[index]['duration'].toString() +
                              ''
                                  '\nPassing Score:  ' +
                              tests[index]['passingScore'].toString(),
                          style: TextStyle(fontSize: 17,color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ])),
            );
          }),
    );
  }

  _groupCards(var groups) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.15,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: groups.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              color: _randomColors[Random().nextInt(_randomColors.length)],
              child: Container(
                  padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
                  width: 200,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                    Text(
                      groups[index]['name'],
                      style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Description: ' + groups[index]['descr'],
                      style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic,color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ])),
            );
          }),
    );
  }

  _studentDashBoard(var data) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: MediaQuery
                .of(context)
                .size.height * 0.02,
          ),
          Center(
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size.width * 0.90,
              height: MediaQuery
                  .of(context)
                  .size.height * 0.15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.lightBlueAccent.shade700),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: Text(
                        '${widget.user['name'][0]}',
                        style: TextStyle(fontSize: 45,color: Colors.blueGrey[900]),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 27,
                        ),
                        Text(
                          widget.user['name'],
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                          color: Colors.white),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          widget.user['roleName'],
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w300,color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Email: '+widget.user['email'],style: TextStyle(color: Colors.white),),
                        Text('Contact: '+widget.user['phone'].toString(),style: TextStyle(color: Colors.white)),
                        Text('Address: '+widget.user['address'],style: TextStyle(color: Colors.white))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.02,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(17, 0, 0, 0),
            child: Text(
              'Assigned Tests:',
              style: TextStyle(fontSize: 25,fontStyle: FontStyle.italic,fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.02,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(17, 0 , 17, 0),
            child: FutureBuilder(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.hasData && widget.dashboard != null) {
                  if (widget.dashboard['assignedTests']['tests'].length != 0)
                    return _assignedTestsCards(
                        widget.dashboard['assignedTests']['tests']);
                  else
                    return Text('Hurrah! No tests have been assigned.');
                } else
                  return CircularProgressIndicator();
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.03,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(17, 0, 0, 0),
            child: Text(
              'Previous Scores:',
              style: TextStyle(fontSize: 25,fontStyle: FontStyle.italic,fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.02,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(17, 0 , 17, 0),
            child: FutureBuilder(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.hasData && widget.dashboard != null) {
                  if (widget.dashboard['scores'].length != 0)
                    return _previousScoresCards(widget.dashboard['scores']);
                  else
                    return Text('Attempt your first test :p');
                } else
                  return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }

  List _randomColors = [Colors.orange.shade800,
    Colors.green.shade900,
    Colors.purple.shade700,
    Colors.red.shade800];

  _assignedTestsCards(var assignedTests) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.34,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: assignedTests.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              color: _randomColors[Random().nextInt(_randomColors.length)],
              child: Container(
                  padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
                  width: 200,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          assignedTests[index]['name'],
                          style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Description: ' + assignedTests[index]['descr'],
                          style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic,color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Attempts Allowed: ' +
                              assignedTests[index]['noOfAttempts'].toString() +
                              '\nDuration:  ' +
                              assignedTests[index]['duration'].toString() +
                              ''
                                  '\nPassing Score:  ' +
                              assignedTests[index]['passingScore'].toString(),
                          style: TextStyle(fontSize: 17,color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        MaterialButton(
                          onPressed: () {
                            _checkEligibility(widget.user['userid'],
                                assignedTests[index]['id']);
                          },
                          child: Text('Take Test',style: TextStyle(fontWeight: FontWeight.w600),),
                          color: Colors.white,
                          textColor: Colors.black,
                          splashColor: Colors.grey,
                        )
                      ])),
            );
          }),
    );
  }

  _previousScoresCards(var previousScores) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.20,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: previousScores.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              color: _randomColors[Random().nextInt(_randomColors.length)],
              child: Container(
                  padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
                  width: 200,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                    Text(
                      previousScores[index]['name'],
                      style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Previous Scores: \n' +
                          previousScores[index]['score'].toString().toString(),
                      style: TextStyle(fontSize: 18,color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Max Marks: ' +
                          previousScores[index]['maxScore'].toString(),
                      style: TextStyle(fontSize: 20,color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ])),
            );
          }),
    );
  }

  _checkEligibility(String userId, int testId) {

    Future future = Server.checkEligibility(userId, testId);

    future.then((response) {
      var jsonString = response.body;
      var object = json.jsonDecode(jsonString);
      if (object) {
        _startTest(testId);
      } else
        _showDialog(
            "You have already attempted this test allowed number of times!");
    }).catchError((err) {
      print("Some error occurred in eligibility !!!!!!" + err.toString());
    });
  }

  _startTest(int testId) {
    Future future = Server.getQuestions(testId);
    print("Future is $future");
    future.then((response) {
      var jsonString = response.body;
      var object = json.jsonDecode(jsonString);
      List<dynamic> list = new List<dynamic>();
      if (object.runtimeType != list.runtimeType)
        _showDialog(object['msg']);
      else
        Navigator.pushNamed(context, '/attemptTest', arguments: {
          'questions': object,
          'size': object.length,
          'userid': widget.user['userid'],
          'testid': testId
        });
    });
  }

  Future<void> _showDialog(String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Take Test'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text(msg)],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
