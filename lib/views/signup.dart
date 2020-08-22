import 'package:Chat_app/services/auth.dart';
import 'package:Chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isLoading = false;

  final formkey = GlobalKey<FormState>();
  TextEditingController usernameedit = new TextEditingController();
  TextEditingController emailedit = new TextEditingController();
  TextEditingController passwordedit = new TextEditingController();

  signMeUp() {
    if (formkey.currentState.validate()) {
      setState(() {
        isLoading = true;
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
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "Sign Up with Google",
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
                            "Already have account?  ",
                            style: bigetextfieldstyle(),
                          ),
                          Text(
                            "SignIn now",
                            style: bigetextfieldstyle(),
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
