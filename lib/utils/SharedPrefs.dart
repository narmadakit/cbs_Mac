import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs{
  static const memberId = "MEMBER_ID";
  static const memberName = "MEMBER_NAME";
  static const memberDetails = "MEMBER_DETAILS";
  static const companyDetails = "COMPANY_DETAILS";
  static const isLogin = "isLogin";
  static const mobileNo = "MOBILE_NO";
  static const depositSchemaDetails = "DEPOSIT_SCHEMA_DETAILS";


  static saveData(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(value));
  }

  static readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return jsonDecode(prefs.getString(key).toString());
  }

  static saveBool(String key, bool value) async {
    print(" save bool -  key : $key, value : $value");
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static readBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<bool> clearPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }

  static void saveString(String myKey, String stringValue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(myKey, stringValue);
    print('String saved! $myKey $stringValue ');
  }

  static getString(String myKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(myKey);
  }
}