import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/Auth/data/model/response/user.dart';
import '../../screens/gradueted_flow/data/model/uploaded_case.dart';

class SharedPrefHelper {
  SharedPrefHelper._();
  static const String userKey = 'logged_in_user';

  static Future<void> saveUser(UserModel user) async {
    final jsonString = jsonEncode(user.toJson());
    await setData('user_data', jsonString);
    await setSecureString('token', user.token);
    await setData('user_role', user.role); // خزني الدور كـ string أو int
    await setData('full_name', user.fullName); // خزني الدور كـ string أو int
    await saveLogin();
  }

  static Future<String?> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_role');
  }

  static Future<String?> getFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('full_name');
  }

  static Future<UserModel?> getUser() async {
    final jsonString = await getString('user_data');
    if (jsonString.isEmpty) return null;
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return UserModel.fromJson(jsonMap);
  }

  static Future<void> setInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<void> clearUser() async {
    await removeData('user_data');
    await removeSecureString('token');
  }

  static Future<String?> getConsultantId() async {
    final user = await getUser();
    return user?.data.consultantId;
  }

  static Future<String?> getFreshGraduatedId() async {
    final user = await getUser();
    return user?.data.freshGradId;
  }

  static Future<void> saveUploadedCase(UploadedCaseModel caseData) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(caseData.toJson());
    await prefs.setString('last_uploaded_case', jsonString);
    print('Case Saved Successfully');
  }

  static Future<UploadedCaseModel?> getUploadedCase() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('last_uploaded_case');
    if (jsonString == null) return null;
    final jsonMap = jsonDecode(jsonString);
    return UploadedCaseModel.fromJson(jsonMap);
  }

  static Future<void> removeData(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }

  static Future<void> clearData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  static Future<void> setData(String key, dynamic value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    switch (value.runtimeType) {
      case String:
        await sharedPreferences.setString(key, value);
        break;
      case int:
        await sharedPreferences.setInt(key, value);
        break;
      case double:
        await sharedPreferences.setDouble(key, value);
        break;
      case bool:
        await sharedPreferences.setBool(key, value);
        break;
      default:
        throw Exception("Unsupported type");
    }
  }

  static Future<String> getString(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? "";
  }

  // static Future<int?> getInt(String key) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   return sharedPreferences.getInt(key);
  // }

  static Future<double?> getDouble(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(key);
  }

  static Future<bool?> getBoolean(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key);
  }

  static final FlutterSecureStorage _flutterSecureStorage =
      FlutterSecureStorage();

  static Future<void> setSecureString(String key, String value) async {
    await _flutterSecureStorage.write(key: key, value: value);
  }

  static Future<String?> getSecureString(String key) async {
    return await _flutterSecureStorage.read(key: key);
  }

  static Future<void> removeSecureString(String key) async {
    await _flutterSecureStorage.delete(key: key);
  }

  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<void> saveLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  static Future<void> clearLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }

  static Future<void> logout() async {
    await clearUser();
    await clearLogin();
    await clearData();
  }
}
