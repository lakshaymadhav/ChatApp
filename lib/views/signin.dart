import 'package:Chat_app/Helper/helperfunc.dart';
import 'package:Chat_app/services/auth.dart';
import 'package:Chat_app/services/database.dart';
import 'package:Chat_app/views/chatroomsscreen.dart';
import 'package:Chat_app/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formkey = GlobalKey<FormState>();
  AuthMethod authMethod = new AuthMethod();
  TextEditingController emailedit = new TextEditingController();
  TextEditingController passwordedit = new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  bool isLoading = false;
  QuerySnapshot snapUserInfo;
  SignInuser() {
    if (formkey.currentState.validate()) {
      HelperFunc.saveUserEmailSharedPref(emailedit.text);
      //
      databaseMethods.getUserEmail(emailedit.text).then((val) {
        snapUserInfo = val;
        HelperFunc.saveUserNameSharedPref(
            snapUserInfo.documents[0].data["name"]);
      });
      setState(() {
        isLoading = true;
      });

      authMethod
          .signinwithemailandpassword(emailedit.text, passwordedit.text)
          .then((value) {
        if (value != null) {
          HelperFunc.saveUserLoginSharedPref(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)
                              ? null
                              : "Enter correct email";
                        },
                        controller: emailedit,
                        style: simpletextfieldstyle(),
                        decoration: textFieldInputDecoration("Email"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (value) {
                          return value.length > 6
                              ? null
                              : "should be more than 6 characters";
                        },
                        controller: passwordedit,
                        style: simpletextfieldstyle(),
                        decoration: textFieldInputDecoration("Password"),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xff202c3b),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "Forgot Password?",
                      style: simpletextfieldstyle(),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    SignInuser();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xff007EF4),
                          const Color(0xff2A75BC)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      "Sign In",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Sign In with Google",
                    style: TextStyle(color: Colors.black87, fontSize: 17),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have account?  ",
                      style: bigetextfieldstyle(),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Register now",
                          style: bigetextfieldstyle(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
