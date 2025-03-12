import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  int selectedIndex;
  ValueChanged<int> onClicked;
  BottomNavigation({Key? key, required this.selectedIndex, required this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      selectedItemColor: Colors.orange,
      onTap: onClicked,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.white,
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Container(
            decoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
            child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: IconButton(
                    onPressed: () =>  { onClicked },
                    icon: Icon(CupertinoIcons.plus, color: Colors.white)
                )
            ),
          ),
          label: 'Add',
        ),
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.bell),
          label: 'Notifications',
        ),
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.news),
          label: 'Blog',
        ),
      ],
    );
  }
}