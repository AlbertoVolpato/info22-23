import 'package:client/main.dart';
import 'package:client/screens/login_page.dart';
import 'package:client/screens/profile_screen.dart';
import 'package:client/screens/profile_screen_one.dart';
import 'package:client/screens_1/add_post_camera.dart';
import 'package:client/screens_1/add_post_screen.dart';
import 'package:client/screens_1/camera_screen.dart';

import 'package:flutter/material.dart';
import 'package:client/screens/post_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int _selectedIndex = 0;

  selectRouter() {
    if (_selectedIndex == 0) {
      // return PostScreenone();
      return PostScreen();
      //[PostScreen(), PostModels()];
    } else if (_selectedIndex == 1) {
    } else if (_selectedIndex == 2) {
      return AddPostScreen();
    } else if (_selectedIndex == 3) {
    } else if (_selectedIndex == 4) {
      return ProfileScreen1();
    }
  }

//QUANDO SI PREME SUL FOOTHER
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(index);
    });
  }

//BARRA FOOTHER
  Widget _bottomNav() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
      child: SizedBox(
        height: 85,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: 34.0,
                color: Colors.black87,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 30.0,
                color: Colors.black87,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_box_outlined,
                size: 34.0,
                color: Colors.black87,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border,
                size: 30.0,
                color: Colors.black87,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                size: 30.0,
                color: Colors.black87,
              ),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

//PAGINA PRINCIPALE
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: selectRouter(),
        bottomNavigationBar: _selectedIndex != 2 ? _bottomNav() : null);
  }
}
