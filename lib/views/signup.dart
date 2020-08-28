import 'package:Chat_app/Helper/helperfunc.dart';
import 'package:Chat_app/services/auth.dart';
import 'package:Chat_app/services/database.dart';
import 'package:Chat_app/views/chatroomsscreen.dart';
import 'package:Chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  final Function toggle;
  Signup(this.toggle);
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isLoading = false;
  AuthMethod authMethod = new AuthMethod();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  HelperFunc helperFunc = new HelperFunc();
  final formkey = GlobalKey<FormState>();
  TextEditingController usernameedit = new TextEditingController();
  TextEditingController emailedit = new TextEditingController();
  TextEditingController passwordedit = new TextEditingController();

  signMeUp() {
    if (formkey.currentState.validate()) {
      Map<String, String> userInfoMap = {
        "name": usernameedit.text,
        "email": emailedit.text
      };

      HelperFunc.saveUserEmailSharedPref(emailedit.text);
      HelperFunc.saveUserNameSharedPref(usernameedit.text);

      setState(() {
        isLoading = true;
      });

      authMethod
          .signUpwithEmail(emailedit.text, passwordedit.text)
          .then((value) {
        databaseMethods.uploadUserInfo(userInfoMap);
        HelperFunc.saveUserLoginSharedPref(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatRoom()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
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
                              validator: (String value) {
                                return value.isEmpty || value.length < 4
                                    ? "Enter a valid username"
                                    : null;
                              },
                              controller: usernameedit,
                              style: simpletextfieldstyle(),
                              decoration: textFieldInputDecoration("Username"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
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
                      GestureDetector(
                        onTap: () {
                          signMeUp();
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
                            "Sign Up",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have account?  ",
                            style: bigetextfieldstyle(),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.toggle();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "SignIn now",
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
