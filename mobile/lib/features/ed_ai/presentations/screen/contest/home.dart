import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile/features/ed_ai/presentations/bloc/scroll/scroll_bloc.dart';
import 'package:mobile/features/ed_ai/presentations/screen/contest/info.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

const image =
    "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";

class ContestHome extends StatefulWidget {
  const ContestHome({super.key});

  static const routeName = '/contest/home';

  @override
  State<ContestHome> createState() => _ContestInfoState();
}

class _ContestInfoState extends State<ContestHome> {
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
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: AdaptiveTheme.of(context).mode.isDark
          ? Brightness.light
          : Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: AdaptiveTheme.of(context).mode.isDark
          ? const Color.fromRGBO(28, 27, 32, 1)
          : const Color.fromRGBO(244, 247, 252, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          height: 50,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                          margin: const EdgeInsets.only(right: 10),
                          width: MediaQuery.of(context).size.width * 0.80,
                          decoration: BoxDecoration(
                            color: AdaptiveTheme.of(context).mode.isDark
                                ? Colors.white.withOpacity(0.05)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search for contest',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AdaptiveTheme.of(context).mode.isDark
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.black.withOpacity(0.5),
                              ),
                              border: InputBorder.none,
                              alignLabelWithHint: true,
                              contentPadding: const EdgeInsets.only(bottom: 4),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AdaptiveTheme.of(context).mode.isDark
                                  ? Colors.white.withOpacity(0.05)
                                  : const Color.fromARGB(255, 0, 69, 104),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(Icons.search,
                                size: 30,
                                color: AdaptiveTheme.of(context).mode.isDark
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 4, 10, 10),
                height: MediaQuery.of(context).size.height * 0.27,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AdaptiveTheme.of(context).mode.isDark
                      ? Colors.white.withOpacity(0.05)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Upcoming Contest',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AdaptiveTheme.of(context).mode.isDark
                                ? Colors.white.withOpacity(0.8)
                                : Colors.black,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'View All',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AdaptiveTheme.of(context).mode.isDark
                                ? Colors.white.withOpacity(0.5)
                                : Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (ctx, index) {
                          return GestureDetector(
                            onTap: () {
                              PersistentNavBarNavigator
                                  .pushNewScreenWithRouteSettings(
                                context,
                                settings: const RouteSettings(
                                    name: '/contest/contest-info'),
                                screen: const ContestInfo(),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: MediaQuery.of(context).size.width * 0.28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Expanded(
                                    child: Image(
                                      image: NetworkImage(image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Division 34 maths contest',
                                    textAlign: TextAlign.start,
                                    softWrap: true,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          AdaptiveTheme.of(context).mode.isDark
                                              ? Colors.white.withOpacity(0.8)
                                              : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
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
                child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 4, 10, 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AdaptiveTheme.of(context).mode.isDark
                        ? Colors.white.withOpacity(0.05)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                onSelectedIndexChanged(0);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: _selectedIndex == 0
                                          ? AdaptiveTheme.of(context)
                                                  .mode
                                                  .isDark
                                              ? Colors.white.withOpacity(0.8)
                                              : Colors.black
                                          : Colors.transparent,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Contest',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: _selectedIndex == 0
                                        ? FontWeight.w600
                                        : FontWeight.w500,
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: _selectedIndex == 1
                                          ? AdaptiveTheme.of(context)
                                                  .mode
                                                  .isDark
                                              ? Colors.white.withOpacity(0.8)
                                              : Colors.black
                                          : Colors.transparent,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Rating',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: _selectedIndex == 1
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                    color: AdaptiveTheme.of(context).mode.isDark
                                        ? Colors.white.withOpacity(0.8)
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            //Filter
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.filter_alt_outlined,
                                size: 25,
                                color: AdaptiveTheme.of(context).mode.isDark
                                    ? Colors.white.withOpacity(0.8)
                                    : const Color.fromARGB(255, 0, 69, 104),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _selectedIndex == 0
                          ? SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.485,
                              child: ListView.builder(
                                controller: _scrollController,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: 20,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color:
                                          AdaptiveTheme.of(context).mode.isDark
                                              ? Colors.white.withOpacity(0.03)
                                              : const Color.fromARGB(
                                                      255, 237, 246, 250)
                                                  .withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: Image(
                                                image: NetworkImage(image),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'General Knowledge',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AdaptiveTheme.of(
                                                                  context)
                                                              .mode
                                                              .isDark
                                                          ? Colors.white
                                                              .withOpacity(0.8)
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    '20.1k participants',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: AdaptiveTheme.of(
                                                                  context)
                                                              .mode
                                                              .isDark
                                                          ? Colors.white
                                                              .withOpacity(0.5)
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 10),
                                            decoration: BoxDecoration(
                                              color: AdaptiveTheme.of(context)
                                                      .mode
                                                      .isDark
                                                  ? Colors.white
                                                      .withOpacity(0.08)
                                                  : const Color.fromARGB(
                                                      255, 0, 69, 104),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              index % 2 == 0 ? 'Join' : 'Enter',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: AdaptiveTheme.of(context)
                                                        .mode
                                                        .isDark
                                                    ? Colors.white
                                                        .withOpacity(0.8)
                                                    : Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          : SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.485,
                              child: ListView.builder(
                                controller: _scrollController,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: 20,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color:
                                          AdaptiveTheme.of(context).mode.isDark
                                              ? Colors.white.withOpacity(0.04)
                                              : const Color.fromARGB(
                                                      255, 237, 246, 250)
                                                  .withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Colors.white,
                                              backgroundImage:
                                                  NetworkImage(image),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'John Doe',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AdaptiveTheme.of(
                                                                  context)
                                                              .mode
                                                              .isDark
                                                          ? Colors.white
                                                              .withOpacity(0.8)
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Ebezer Scrooge',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: AdaptiveTheme.of(
                                                                  context)
                                                              .mode
                                                              .isDark
                                                          ? Colors.white
                                                              .withOpacity(0.5)
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Text(
                                          '20.1k',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: AdaptiveTheme.of(context)
                                                    .mode
                                                    .isDark
                                                ? Colors.white.withOpacity(0.8)
                                                : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
