import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/ed_ai/presentations/bloc/scroll/scroll_bloc.dart';

const image =
    "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";

class ContestStanding extends StatefulWidget {
  const ContestStanding({Key? key}) : super(key: key);

  static const routeName = '/contest/standing';

  @override
  State<ContestStanding> createState() => _ContestStandingState();
}

class _ContestStandingState extends State<ContestStanding> {
  void barColor() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
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
    barColor();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    barColor();
    return Scaffold(
      backgroundColor: AdaptiveTheme.of(context).mode.isDark
          ? const Color.fromRGBO(28, 27, 32, 1)
          : const Color.fromARGB(255, 0, 69, 104),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 8, bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<ScrollBloc>(context)
                                  .add(ToggleVisibilityEvent(isVisible: false));
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_sharp,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                              ),
                              SizedBox(
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
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '20.1k participants',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
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
                        onTap: () {},
                        child: const Icon(
                          Icons.more_vert_outlined,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  minVerticalPadding: 0,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  leading: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: const Row(children: [
                      Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Text(
                          'Rank',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ]),
                  ),
                  title: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: const Text(
                        'Point',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      )),
                  trailing: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: const Text(
                      'Time',
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
            Expanded(
              child: Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),
                decoration: BoxDecoration(
                  color: AdaptiveTheme.of(context).mode.isDark
                      ? Colors.white.withOpacity(0.03)
                      : const Color.fromARGB(255, 237, 246, 250),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: 50,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 0.2,
                      child: ListTile(
                        leading: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: [
                              Text(
                                '${index + 1}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AdaptiveTheme.of(context).mode.isDark
                                      ? Colors.white.withOpacity(0.5)
                                      : Colors.black,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const CircleAvatar(
                                radius: 14,
                                backgroundImage: NetworkImage(
                                  image,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Khanh',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AdaptiveTheme.of(context).mode.isDark
                                      ? Colors.white.withOpacity(0.5)
                                      : Colors.black,
                                ),
                              ),
                            ]),
                          ),
                        ),
                        title: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Text(
                              '100',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AdaptiveTheme.of(context).mode.isDark
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.black,
                              ),
                            )),
                        trailing: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Text(
                              '00:32:01',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AdaptiveTheme.of(context).mode.isDark
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.black,
                              ),
                            )),
                        onTap: () {
                          // Handle tapping on a question
                        },
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
