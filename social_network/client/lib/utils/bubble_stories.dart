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

class BubbleStories extends StatefulWidget {
  final String text;

  BubbleStories({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
              width: 60,
              height: 60,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.grey)),
          SizedBox(
            height: 10,
          ),
          Text(text)
        ],
      ),
    );
  }
}
