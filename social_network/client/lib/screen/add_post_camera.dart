import 'package:flutter/material.dart';
import 'package:client/common/utils.dart';
import 'package:client/widgets/add_post_camera_button.dart';

class AddPostCamera extends StatefulWidget {
  const AddPostCamera({super.key});
  @override
  _AddPostCamera createState() => _AddPostCamera();
}

class _AddPostCamera extends State<AddPostCamera> {
  @override
  Widget build(BuildContext context) {
    Size _screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: _screen.height,
        width: _screen.width,
        child: Column(
          children: <Widget>[
            Container(
              height: 410,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image(
                    image: NetworkImage(Utils.listOfImageUrl.elementAt(10)),
                    fit: BoxFit.cover,
                  ),
                  cameraOptions(),
                ],
              ),
            ),
            Container(
              height: _screen.height - 410 - 45 - 45,
              color: Color(0xFFEDF0F6),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 85,
                      height: 85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
