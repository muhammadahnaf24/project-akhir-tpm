import 'package:project_akhir_tpm/utils/enkripsi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import 'package:collection/collection.dart';
import '../models/user_model.dart';

class LoginController {
  Future<bool> login(UserModel user) async {
    try {
      var box = await Hive.openBox<UserModel>('users');
      final storedUser = box.values.firstWhereOrNull(
              (u) => u.username == user.username &&
              u.password == EncryptionHelper.encryptText(user.password)
      );

      if (storedUser != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('currentUser', storedUser.username);
        return true;
      }
      return false;
    } catch (e) {
      print("Login failed with error: $e");
      return false;
    }
  }

  Future<bool> register(UserModel user) async {
    try {
      var box = await Hive.openBox<UserModel>('users');
      final userExists = box.values.any((u) => u.username == user.username);

      if (userExists) {
        return false; // User already exists
      } else {
        // Encrypt the password once
        user.password = EncryptionHelper.encryptText(user.password);
        await box.add(user);
        return true;
      }
    } catch (e) {
      print("Registration failed with error: $e");
      return false;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('currentUser');
  }
}
