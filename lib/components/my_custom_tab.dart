// ignore_for_file: use_build_context_synchronously
import 'package:demo/screens/Auth/posts/my_posts_screen.dart';
import 'package:demo/screens/Auth/users/my_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/UnAuth/my_login.dart';
import '../utils/Constants/const.dart';

class MyCustomTab extends StatefulWidget {
  const MyCustomTab({super.key});

  @override
  State<MyCustomTab> createState() => _MyCustomTabState();
}

class _MyCustomTabState extends State<MyCustomTab> {
  int _selectedIndex = 0;

  final bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Posts',
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void onPressLogout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(TOKEN);
    Route route = MaterialPageRoute(
      builder: (context) => const MyLoginScreen(),
    );
    Navigator.pushReplacement(
      context,
      route,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bottomItems[_selectedIndex].label.toString()),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              size: 25,
            ),
            onPressed: () {
              onPressLogout(context);
            },
          ),
        ],
      ),
      body: Center(
        child:
            _selectedIndex == 0 ? const MyHomeScreen() : const MyPostsScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
