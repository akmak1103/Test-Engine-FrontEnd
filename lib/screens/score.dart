import 'package:flutter/material.dart';

class Score extends StatefulWidget {
  @override
  _ScoreState createState() => _ScoreState();
  var data;
  var selectedAns;
}

class _ScoreState extends State<Score> {
  @override
  Widget build(BuildContext context) {
    Map<String,dynamic> args = ModalRoute.of(context).settings.arguments;
    widget.data = args['data'];
    widget.selectedAns = args['selectedAns'];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Total Score: '+widget.data['totalScore'].toString(),style: TextStyle(fontSize: 30),),
              SizedBox(height: 10,),
              Text('Max Score: '+widget.data['maxScore'].toString(),style: TextStyle(fontSize: 25),),
              SizedBox(height: 30,),
              ListView.builder(
                shrinkWrap: true,
                  itemCount: widget.selectedAns.length,
                  itemBuilder: (context,index){
                  return ListTile(
                    title: Text('Correct Answer: '+widget.data['correctOption'][index],style: TextStyle(fontSize: 20),),
                    leading: Text((index+1).toString(),style: TextStyle(fontSize: 20),),
                    subtitle: Text('Chosen Answer: '+widget.selectedAns[index],style: TextStyle(fontSize: 16),),
                  );
                  },
              padding: EdgeInsets.all(5),)
            ],
          ),
        ),
      ),
    );
  }
}
