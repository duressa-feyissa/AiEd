import 'package:flutter/material.dart';
import 'package:mobile/screen/contest/home.dart';
import 'package:mobile/screen/contest/info.dart';
import 'package:mobile/screen/contest/standing.dart';

class ContestLayout extends StatefulWidget {
  const ContestLayout({Key? key, required this.onChangeUpperBgColor})
      : super(key: key);

  final void Function(String key) onChangeUpperBgColor;

  @override
  State<StatefulWidget> createState() {
    return _ContestLayoutState();
  }
}

class _ContestLayoutState extends State<ContestLayout> {
  int _selectedIndex = 0;

  void onTabTapped(int index) {
    if (index == 0 || index == 1) {
      widget.onChangeUpperBgColor('white');
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      ContestHome(
        context: context,
      ),
      ContestInfo(),
      Standing(onTap: onTabTapped),
      const Center(child: Text('Guide')),
      const Center(child: Text('Profile')),
    ];
    return Container(
      color: const Color.fromARGB(255, 0, 69, 104),
      child: widgetOptions.elementAt(_selectedIndex),
    );
  }
}
