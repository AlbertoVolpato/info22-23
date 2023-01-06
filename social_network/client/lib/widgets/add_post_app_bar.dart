import 'package:client/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';

class AddPostAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String screenName;

  const AddPostAppBar({
    Key? key,
    required this.height,
    required this.screenName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Color(0xFFEDF0F6),
      //color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MaterialButton(
            child: Text(
              'Cancel',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 18,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
              //FlutterStatusbarManager.setHidden(false);
            },
          ),
          MaterialButton(
            child: screenName == 'gallery'
                ? Row(
                    children: [
                      Text(
                        'Recent',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Ionicons.ios_arrow_down,
                        color: Colors.black87,
                      )
                    ],
                  )
                : Text(
                    screenName == 'camera' ? 'Photo' : 'Video',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
            onPressed: () {},
          ),
          screenName == 'gallery'
              ? MaterialButton(
                  child: Text(
                    '   Next',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {},
                )
              : MaterialButton(
                  child: Container(),
                  onPressed: () {},
                ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
