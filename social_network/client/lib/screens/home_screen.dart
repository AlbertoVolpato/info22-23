import 'package:client/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:client/models/post_model.dart';
import 'package:client/screens/post_screen.dart';
import 'package:client/models/post_api.dart';
import 'package:client/screens/view_post_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int _selectedIndex = 0;

  selectRouteIndex() {
    if (_selectedIndex == 0) {
      return PostScreen();
      //[PostScreen(), PostModels()];
    } else if (_selectedIndex == 1) {
    } else if (_selectedIndex == 3) {
    } else if (_selectedIndex == 4) {
      return Profile();
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
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
              size: 30.0,
              color: Colors.grey,
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 30.0,
              color: Colors.grey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: MaterialButton(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Color(0xFF23B66F),
                onPressed: () => print('Upload photo'),
                child: Icon(
                  Icons.add,
                  size: 35.0,
                  color: Colors.white,
                ),
              ),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
              size: 30.0,
              color: Colors.grey,
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              size: 30.0,
              color: Colors.grey,
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

//PAGINA PRINCIPALE
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: selectRouteIndex(), bottomNavigationBar: _bottomNav());
  }
}
