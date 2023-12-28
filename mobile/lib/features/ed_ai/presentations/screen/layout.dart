import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/ed_ai/presentations/bloc/scroll/scroll_bloc.dart';

import 'package:mobile/features/ed_ai/presentations/screen/contest/home.dart';
import 'package:mobile/features/ed_ai/presentations/screen/contest/info.dart';
import 'package:mobile/features/ed_ai/presentations/screen/home/home.dart';
import 'package:mobile/features/ed_ai/presentations/screen/problem/home.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LayoutState();
  }
}

class _LayoutState extends State<Layout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_outlined),
        title: 'Home',
        activeColorPrimary: AdaptiveTheme.of(context).mode.isDark
            ? Colors.white.withOpacity(0.8)
            : const Color.fromARGB(255, 0, 69, 104),
        inactiveColorPrimary: Colors.grey[600],
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.emoji_events_outlined),
        title: 'Contest',
        activeColorPrimary: AdaptiveTheme.of(context).mode.isDark
            ? Colors.white.withOpacity(0.8)
            : const Color.fromARGB(255, 0, 69, 104),
        inactiveColorPrimary: Colors.grey[600],
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.assignment_outlined),
        title: 'Problem',
        activeColorPrimary: AdaptiveTheme.of(context).mode.isDark
            ? Colors.white.withOpacity(0.8)
            : const Color.fromARGB(255, 0, 69, 104),
        inactiveColorPrimary: Colors.grey[600],
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.book_outlined),
        title: 'Guide',
        activeColorPrimary: AdaptiveTheme.of(context).mode.isDark
            ? Colors.white.withOpacity(0.8)
            : const Color.fromARGB(255, 0, 69, 104),
        inactiveColorPrimary: Colors.grey[600],
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_outline),
        title: 'Profile',
        activeColorPrimary: AdaptiveTheme.of(context).mode.isDark
            ? Colors.white.withOpacity(0.8)
            : const Color.fromARGB(255, 0, 69, 104),
        inactiveColorPrimary: Colors.grey[600],
      ),
    ];
  }

  bool _hideNavBar = false;

  void _onHideNavBar(bool hidden) {
    setState(() {
      _hideNavBar = hidden;
    });
  }

  List<Widget> _buildScreens() {
    return [
      const Home(),
      const ContestHome(),
      const ProblemHome(),
      const ContestInfo(),
      Container(
        color: const Color.fromARGB(255, 237, 246, 250).withOpacity(0.6),
        child: Switch(
          value: AdaptiveTheme.of(context).mode.isDark,
          onChanged: (value) {
            if (value) {
              AdaptiveTheme.of(context).setDark();
            } else {
              AdaptiveTheme.of(context).setLight();
            }
          },
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScrollBloc(),
      child: SizedBox(
        child: BlocListener<ScrollBloc, ScrollState>(
          listener: (context, state) {
            _onHideNavBar(state.isVisible);
          },
          child: PersistentTabView(
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            backgroundColor: AdaptiveTheme.of(context).mode.isDark
                ? const Color.fromARGB(255, 23, 21, 21)
                : const Color.fromARGB(255, 255, 255, 255),
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            hideNavigationBarWhenKeyboardShows: true,
            hideNavigationBar: _hideNavBar,
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: const ItemAnimationProperties(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation(
              animateTabTransition: true,
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle.style6,
          ),
        ),
      ),
    );
  }
}
