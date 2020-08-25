import 'package:Chat_app/Helper/authenticate.dart';
import 'package:Chat_app/Helper/helperfunc.dart';
import 'package:Chat_app/views/chatroomsscreen.dart';
import 'package:Chat_app/views/search.dart';
import 'package:Chat_app/views/signin.dart';
import 'package:Chat_app/views/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userLog = false;
  @override
  void initState() {
    // TODO: implement initState
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunc.getUserLoginSharedPref().then((value) {
      setState(() {
        userLog = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff145C9E),
        scaffoldBackgroundColor: Color(0xff1F1F1F),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: userLog ? ChatRoom() : Authenticate(),
    );
  }
}
