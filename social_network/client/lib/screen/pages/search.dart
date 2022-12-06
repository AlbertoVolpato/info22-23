import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:client/screen/origin_screen.dart';
import 'package:client/screen/homepage.dart';
import 'package:client/screen/login.dart';
import 'package:client/screen/register.dart';
import 'package:client/screen/account.dart';
import 'package:client/screen/reels.dart';
import 'package:client/screen/home.dart';
import 'package:client/screen/search.dart';
import 'package:client/screen/shop.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);
  @override
  State<Search> createState() => _Search();
}

class _Search extends State<Search> {
  int _selectedIndex = 0;
  void _navigationBottomNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [
    Center(child: Text('HOME')),
    Center(child: Text('SEARCH')),
    Center(child: Text('REELS')),
    Center(child: Text('SHOP')),
    Center(child: Text('ACCOUNT')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: _children[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _navigationBottomNavBar,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_call), label: 'reels'),
            BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'shop'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'account'),
          ],
        ));
  }
}
