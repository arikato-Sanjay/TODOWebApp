import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceFunction{

  static String userIdKey = "LoggedIN";

  static Future<void> saveUserId(String userID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(userIdKey, userID);
  }

  static Future<String> getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(userIdKey);
  }
}