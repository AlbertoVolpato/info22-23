import 'package:flutter/material.dart';

class SelectionBar extends StatelessWidget {
  final Function onTap;
  final int currentIndex;

  SelectionBar({this.onTap, this.currentIndex});

  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Text('✊', style: TextStyle(fontSize: 45)),
          label: 'Sasso',
        ),
        BottomNavigationBarItem(
          icon: Text('✋', style: TextStyle(fontSize: 45)),
          label: 'Carta',
        ),
        BottomNavigationBarItem(
            icon: Text('✌️', style: TextStyle(fontSize: 45)), label: 'Forbice')
      ],
      selectedLabelStyle: TextStyle(fontSize: 22),
      unselectedLabelStyle: TextStyle(fontSize: 18),
      onTap: onTap,
      currentIndex: currentIndex,
    );
  }
}
