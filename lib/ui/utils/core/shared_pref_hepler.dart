//
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SharedPrefHelper {
//   SharedPrefHelper._();
//
//   /// Remove value with [key] from SharedPreferences
//   static removeData(String key) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     await sharedPreferences.remove(key);
//   }
//
//   /// Removes all keys and values in the SharedPreferences
//   static clearData() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     sharedPreferences.clear();
//   }
//
//   /// Saves a [value] with a [key] in the SharedPreferences.
//   static setDate(String key, value) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     switch (value.runtimeType) {
//       case String:
//         sharedPreferences.setString(key, value);
//         break;
//       case int:
//         sharedPreferences.setInt(key, value);
//         break;
//       case double:
//         sharedPreferences.setDouble(key, value);
//         break;
//       case bool:
//         sharedPreferences.setBool(key, value);
//         break;
//       default:
//         return null;
//     }
//   }
//
//   /// Return a string value for [key] from SharedPreferences
//   static getString(String key) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     return sharedPreferences.getString(key) ?? "";
//   }
//
//   /// Return a integer value for [key] from SharedPreferences
//   static getInt(String key) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     return sharedPreferences.getInt(key);
//   }
//
//   /// Return a double value for [key] from SharedPreferences
//   static getDouble(String key) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     return sharedPreferences.getDouble(key);
//   }
//
//   /// Return a boolean value for [key] from SharedPreferences
//   static getBoolean(String key) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     return sharedPreferences.getBool(key);
//   }
//
//   /// Save secure String [value] with [key]
//   static setSecureString(String key, String value) async {
//     final flutterSecureStorage = FlutterSecureStorage();
//     await flutterSecureStorage.write(key: key, value: value);
//   }
//
//   /// Return a secured String [value] with [key]
//   static Future<String?> getSecureString(String key) async {
//     final flutterSecureStorage = FlutterSecureStorage();
//     return await flutterSecureStorage.read(key: key);
//   }
//
//   /// Remove secure data with [key]
//   static removeSecureString(String key) async {
//     final flutterSecureStorage = FlutterSecureStorage();
//     await flutterSecureStorage.delete(key: key);
//   }
// }
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  SharedPrefHelper._();

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

  static Future<int?> getInt(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key);
  }

  static Future<double?> getDouble(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(key);
  }

  static Future<bool?> getBoolean(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key);
  }

  static final FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

  static Future<void> setSecureString(String key, String value) async {
    await _flutterSecureStorage.write(key: key, value: value);
  }

  static Future<String?> getSecureString(String key) async {
    return await _flutterSecureStorage.read(key: key);
  }

  static Future<void> removeSecureString(String key) async {
    await _flutterSecureStorage.delete(key: key);
  }
}
