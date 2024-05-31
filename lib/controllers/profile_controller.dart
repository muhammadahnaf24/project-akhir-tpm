import 'package:flutter/material.dart';
import 'package:project_akhir_tpm/models/user_model.dart';
import 'package:project_akhir_tpm/views/profile.dart';
import 'package:hive/hive.dart';

class ProfileController {
  final Box<UserModel> userBox = Hive.box<UserModel>('users');

  void goToProfile(BuildContext context) {
    final userModel = userBox.get('currentUser');
    if (userModel != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileView(user: userModel),
        ),
      );
    } else {
      print('No user found');
    }
  }
}
