import 'package:flutter/material.dart';

class SelectionBar extends StatelessWidget {
  Function onTap;
  int currentIndex;

  SelectionBar({required this.onTap, required this.currentIndex});

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
              icon: Text('✌️', style: TextStyle(fontSize: 45)),
              label: 'Forbice')
        ],
        selectedLabelStyle: TextStyle(fontSize: 22),
        unselectedLabelStyle: TextStyle(fontSize: 18),
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
        });
  }
}
