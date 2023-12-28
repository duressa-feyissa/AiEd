import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile/data/contestInfo.dart';
import 'package:mobile/features/ed_ai/presentations/bloc/scroll/scroll_bloc.dart';
import 'package:mobile/features/ed_ai/presentations/screen/contest/question.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

const image =
    "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";

class ContestInfo extends StatefulWidget {
  const ContestInfo({super.key});

  static const routeName = '/contest/contest-info';

  @override
  State<ContestInfo> createState() => _ContestInfoState();
}

class _ContestInfoState extends State<ContestInfo> {
  int _selectedIndex = 0;

  void onSelectedIndexChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final ScrollController _scrollController = ScrollController();
  Timer? _scrollEndTimer;

  void _scrollListener() {
    final ScrollBloc scrollBloc = BlocProvider.of<ScrollBloc>(context);

    if (_scrollEndTimer != null && _scrollEndTimer!.isActive) {
      _scrollEndTimer!.cancel();
    }

    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      scrollBloc.add(ToggleVisibilityEvent(isVisible: true));
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      scrollBloc.add(ToggleVisibilityEvent(isVisible: false));
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void barColor() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: AdaptiveTheme.of(context).mode.isDark
              ? Brightness.light
              : Brightness.dark),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdaptiveTheme.of(context).mode.isDark
          ? const Color.fromRGBO(28, 27, 32, 1)
          : const Color.fromRGBO(244, 247, 252, 1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.arrow_back,
                              size: 40,
                              color: AdaptiveTheme.of(context).mode.isDark
                                  ? Colors.white.withOpacity(0.8)
                                  : Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.blue,
                                backgroundImage: NetworkImage(image),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'General Knowledge',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AdaptiveTheme.of(context)
                                                .mode
                                                .isDark
                                            ? Colors.white.withOpacity(0.8)
                                            : Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '20.1k participants',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: AdaptiveTheme.of(context)
                                                .mode
                                                .isDark
                                            ? Colors.white.withOpacity(0.5)
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          await PersistentNavBarNavigator
                              .pushNewScreenWithRouteSettings(
                            context,
                            settings:
                                const RouteSettings(name: '/contest/question'),
                            screen: const Question(),
                            withNavBar: true,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                          barColor();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AdaptiveTheme.of(context).mode.isDark
                                ? Colors.white.withOpacity(0.05)
                                : const Color.fromARGB(255, 0, 69, 104),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Join',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        onSelectedIndexChanged(0);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedIndex == 0
                                  ? AdaptiveTheme.of(context).mode.isDark
                                      ? Colors.white.withOpacity(0.8)
                                      : Colors.black
                                  : Colors.transparent,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Text(
                          'General',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AdaptiveTheme.of(context).mode.isDark
                                ? Colors.white.withOpacity(0.8)
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        onSelectedIndexChanged(1);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedIndex == 1
                                  ? AdaptiveTheme.of(context).mode.isDark
                                      ? Colors.white.withOpacity(0.8)
                                      : Colors.black
                                  : Colors.transparent,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Text(
                          'Sponsored',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AdaptiveTheme.of(context).mode.isDark
                                ? Colors.white.withOpacity(0.8)
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ]),
            ),
            Expanded(
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! > 0) {
                    setState(() {
                      if (_selectedIndex > 0) {
                        onSelectedIndexChanged(_selectedIndex - 1);
                      }
                    });
                  } else {
                    setState(() {
                      if (_selectedIndex < 1) {
                        onSelectedIndexChanged(_selectedIndex + 1);
                      }
                    });
                  }
                },
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(bottom: 10),
                  itemCount: _selectedIndex == 0
                      ? contestInformation.length
                      : contestSponsor.length,
                  itemBuilder: (context, index) {
                    var displayData = _selectedIndex == 0
                        ? contestInformation[index]
                        : contestSponsor[index];
                    return Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (int i = 0; i < displayData.data.length; i++)
                            Container(
                              padding: EdgeInsets.only(
                                  top: 8,
                                  left: 12,
                                  right: 12,
                                  bottom: displayData.data.length - 1 == i
                                      ? 12
                                      : 0),
                              color: AdaptiveTheme.of(context).mode.isDark
                                  ? Colors.white.withOpacity(0.03)
                                  : Colors.white,
                              child: displayData.data[i].type == 'image'
                                  ? Image.network(displayData.data[i].value)
                                  : displayData.data[i].type == 'title'
                                      ? Text(
                                          displayData.data[i].value,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: AdaptiveTheme.of(context)
                                                    .mode
                                                    .isDark
                                                ? Colors.white.withOpacity(0.8)
                                                : Colors.black,
                                          ),
                                        )
                                      : Text(
                                          displayData.data[i].value,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: AdaptiveTheme.of(context)
                                                    .mode
                                                    .isDark
                                                ? Colors.white.withOpacity(0.5)
                                                : Colors.black,
                                          ),
                                        ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
