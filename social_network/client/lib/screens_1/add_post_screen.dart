import 'package:flutter/material.dart';
import 'package:client/screens_1/add_post_camera.dart';
import 'package:client/screens_1/add_post_gallery.dart';
import 'package:client/screens_1/add_post_video.dart';
import 'package:client/widgets/add_post_bottom_bar.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  var _pages = [
    AddPostGallery(),
    AddPostCamera(),
    AddPostVideo(),
  ];

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF0F6),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => pageIndex = index);
        },
        children: _pages,
      ),
      bottomNavigationBar: AddPostBottomBar(
        onTap: (value) {
          _onItemTapped(value);
        },
        height: 45,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;
      //
      //
      //using this page controller you can make beautiful animation effects
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }
}
