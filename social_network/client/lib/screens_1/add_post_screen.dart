import 'package:client/screens/home_screen.dart';
import 'package:client/screens/screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:client/screens_1/add_post_camera.dart';
import 'package:client/screens_1/add_post_gallery.dart';

import 'camera_screen.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  int _selectedIndex = 0;

  selectRouter() {
    if (_selectedIndex == 0) {
      return AddPostGallery();
    } else if (_selectedIndex == 1) {
      return CameraApp();
    }
  }

//QUANDO SI PREME SUL FOOTHER
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(index);
    });
  }

  @override
  Widget AddPostBottomBar() {
    return Container(
      color: Color(0xFFEDF0F6),
      height: 65,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_photo_alternate_outlined,
              size: 34.0,
              color: Colors.black87,
            ),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_alt_outlined,
              size: 34.0,
              color: Colors.black87,
            ),
            label: 'Camera',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget AddPostAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MaterialButton(
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 18,
                  ),
                ),
                onPressed: () {}),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF0F6),
      appBar: AppBar(
        leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ScreenController()),
              );
            }), //automaticallyImplyLeading: false,
        actions: [AddPostAppBar()],
        backgroundColor: Color(0xFFEDF0F6),
      ),
      body: (selectRouter()),
      bottomNavigationBar: AddPostBottomBar(),
    );
  }
}
