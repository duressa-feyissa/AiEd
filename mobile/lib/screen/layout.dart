import 'package:flutter/material.dart';
import 'package:mobile/screen/contest/home.dart';
import 'package:mobile/screen/contest/info.dart';
import 'package:mobile/screen/contest/question.dart';

class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LayoutState();
  }
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 0;
  String _selectedKey = 'primaryColor';

  void onTabTapped(int index) {
    if (index == 0 || index == 1) {
      onChangeUpperBackground('white');
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  void onChangeUpperBackground(String key) {
    setState(() {
      _selectedKey = key;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      Text('Index 0: Home'),
      ContestHome(context: context),
      Question(),
      ContestInfo(),
      const Center(child: Text('Profile')),
    ];

    const Map<String, Color> colorMap = {
      'white': Colors.white,
      'primaryColor': Color.fromARGB(255, 0, 69, 104),
      'transparent': Colors.transparent,
    };

    return Scaffold(
      backgroundColor: colorMap[_selectedKey],
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: widgetOptions,
        ),
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events_outlined),
              label: 'Contest',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined),
              label: 'Problem',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              label: 'Guide',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color.fromARGB(255, 0, 69, 104),
          unselectedItemColor: Colors.grey[600],
          onTap: onTabTapped,
        ),
      ),
    );
  }
}
