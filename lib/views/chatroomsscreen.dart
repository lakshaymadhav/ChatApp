import 'package:Chat_app/Helper/authenticate.dart';
import 'package:Chat_app/Helper/constants.dart';
import 'package:Chat_app/Helper/helperfunc.dart';
import 'package:Chat_app/services/auth.dart';
import 'package:Chat_app/views/search.dart';
import 'package:Chat_app/views/signin.dart';
import 'package:Chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethod authMethod = new AuthMethod();

  @override
  void initState() {
    // TODO: implement initState
    getUserinfo();
    super.initState();
  }

  getUserinfo() async {
    Constants.myName = await HelperFunc.getUserNameSharedPref();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat App"),
        actions: [
          GestureDetector(
            onTap: () {
              authMethod.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Authenticate(),
                  ));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(),
              ));
        },
      ),
    );
  }
}
