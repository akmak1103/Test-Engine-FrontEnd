import 'package:flutter/material.dart';
import '../screens/addTest.dart';
import '../utils/server.dart';
import 'dart:convert' as json;
import 'dart:async';

class Tests extends StatefulWidget {
  @override
  _TestsState createState() => _TestsState();
  var tests;
}

class _TestsState extends State<Tests> {
  _getAllTests(String userid) {
    Future future = Server.fetchAllTests(userid);
    future.then((response) {
      var jsonString = response.body;
      var object = json.jsonDecode(jsonString);
      if (object[0] != null) {
        widget.tests = object;
      } else {
        print("COULD NOT FETCH ANY TESTS");
      }
    }).catchError((err) {
      print("Some error occurred !!!!!!");
    });

    return future;
  }

  @override
  Widget build(BuildContext context) {
    Map<String,String> args = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tests'),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshPage,
          child: Column(
            children: <Widget>[
              FutureBuilder(
                  future: _getAllTests(args['userid']),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if(widget.tests != null){
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: (widget.tests.length),
                          itemBuilder: (context, index) {
                            return ListTile(
                              title:
                                  Text('${widget.tests[index]['name']}',style: TextStyle(fontSize: 25),),
                              subtitle:
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('${widget.tests[index]['descr']}'),
                                      Text(('Duration: ${widget.tests[index]['duration']}')),
                                      Text(('Passing Score: ${widget.tests[index]['passingScore']}')),
                                      Text(('Attempts allowed: ${widget.tests[index]['noOfAttempts']}')),
                                      SizedBox(height: 15,)
                                    ],
                                  ),
                              leading: Text('${index+1}',style: TextStyle(fontSize: 22),),
                            );
                          },
                        ),
                      );}
                      else{return CircularProgressIndicator();}
                    } else
                      return CircularProgressIndicator();
                  })
            ],
          ),
        ),
//        floatingActionButton: FloatingActionButton(
//          elevation: 5,
//          child: Icon(Icons.add),
//          onPressed: () {
//            Navigator.push(
//                context, MaterialPageRoute(builder: (c) => AddTest(args['userid'])));
//          },
//      ),
      ),
    );
  }

  Future<Null> _refreshPage() async
  {
    await new Future.delayed(new Duration(seconds: 1));
    setState(() {

    });
    return null;
  }
}
