import 'package:flutter/material.dart';
import './screens/addQue.dart';
import './screens/score.dart';
import './screens/attemptTest.dart';
import './screens/addGroup.dart';
import './screens/addTest.dart';
import './screens/splashScreen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Test Engine',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/tests':(context) => AddTest(),
        '/questions':(context) => AddQuestion(),
        '/groups':(context) => AddGroup(),
        '/attemptTest':(context) => AttemptTest(),
        '/score':(context) => Score()
      },
    );
  }
}