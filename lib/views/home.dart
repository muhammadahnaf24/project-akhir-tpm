// lib/views/home.dart
import 'package:flutter/material.dart';
import 'package:project_akhir_tpm/views/jellybean.dart';
import 'package:project_akhir_tpm/views/konversi_uang.dart';
import 'package:project_akhir_tpm/views/konversi_waktu.dart';
import 'package:project_akhir_tpm/views/profile.dart';
import 'package:hive/hive.dart';
import 'package:project_akhir_tpm/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  UserModel? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  void _loadCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('currentUser');
    final userBox = Hive.box<UserModel>('users');
    setState(() {
      _currentUser = userBox.values.firstWhereOrNull((user) => user.username == username);
    });
  }

  final List<Widget> _children = [
    JellyBeanListScreen(),
    CurrencyConversionView(),
    TimeConversionView(),
    ProfileView(user: UserModel(username: '', password: '', nama: '', email: '', nohp: '')), // Placeholder for ProfileView
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentIndex == 3 && _currentUser != null) {
      _children[3] = ProfileView(user: _currentUser!);
    }

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money, size: 30),
            label: 'Currency',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time, size: 30),
            label: 'Time',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, size: 30),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
