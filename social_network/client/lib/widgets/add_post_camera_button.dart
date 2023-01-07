import 'package:flutter/material.dart';

Widget cameraOptions() {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.cached,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.flash_on,
            color: Colors.white,
            size: 30,
          )
        ],
      ),
    ),
  );
}
