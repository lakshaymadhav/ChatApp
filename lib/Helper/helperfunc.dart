import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class HelperFunc {
  static String sharedpreflogkey = "ISLOGGEDIN";
  static String sharedprefusernamekey = "USERNAMKEKEY";
  static String sharedprefusermailkey = "USEREMAILKEY";

  static Future<bool> saveUserLoginSharedPref(bool isUserLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedpreflogkey, isUserLogin);
  }

  static Future<bool> saveUserNameSharedPref(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedprefusernamekey, userName);
  }

  static Future<bool> saveUserEmailSharedPref(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedprefusermailkey, userEmail);
  }

  static Future<bool> getUserLoginSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedpreflogkey);
  }

  static Future<String> getUserNameSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedprefusernamekey);
  }

  static Future<String> getUserEmailSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedprefusermailkey);
  }
}
