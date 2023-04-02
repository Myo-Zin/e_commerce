
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider((ref) => SharedPreferencesService());

class SharedPreferencesService {
  String isLogin = "isLogin";
  String userId = "userId";
  static const String authToken = "Auth";

  Future<bool> setAuthState({required bool value}) async {
    final sp = await SharedPreferences.getInstance();
    return sp.setBool(isLogin, value);
  }

  Future<bool?> getAuthState() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getBool(isLogin);
  }

  Future<bool> setUserId({required String value}) async{
    final sp = await SharedPreferences.getInstance();
    return sp.setString(userId, value);
  }
  Future<String?> getUserId() async {
    final sp = await SharedPreferences.getInstance();
    final user = sp.getString(userId);
    if (user != null) {
      return  user;
    } else {
      return null;
    }
  }
  static Future<bool> clear() async {
    final sp = await SharedPreferences.getInstance();
    return sp.clear();
  }
  static Future<void> setAuth(String token) async {
    final shp = await SharedPreferences.getInstance();
    shp.setString(authToken, token);
  }

  static Future<String?> getAuth() async {
    final shp = await SharedPreferences.getInstance();
    final result = shp.getString(authToken);
    return result;
  }

}