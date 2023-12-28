import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/ed_ai/presentations/bloc/scroll/scroll_bloc.dart';

const image =
    "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";

class ProblemHome extends StatefulWidget {
  const ProblemHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProblemHomeState();
}

class _ProblemHomeState extends State<ProblemHome> {
  final List<String> mainFilter = [
    'Course',
    'Difficulty',
    'Grade',
    'Source',
    'Year',
  ];

  final Map<String, List<String>> minorFilter = {
    'Course': ['Math', 'Physics', 'Chemistry', 'Biology'],
    'Difficulty': ['Easy', 'Medium', 'Hard'],
    'Grade': ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
    'Source': ['JEE', 'NEET', 'GATE', 'CAT', 'GRE', 'GMAT'],
    'Year': ['2021', '2020', '2019', '2018', '2017', '2016'],
    'default': []
  };

  final Map<String, Set<String>> selectedFilter = {
    'Course': {},
    'Difficulty': {},
    'Grade': {},
    'Source': {},
    'Year': {},
    'default': {}
  };

  void selectMinorFilter(String key) {
    if (key == 'default' || currentSelected == 'default') return;
    if (selectedFilter.containsKey(currentSelected)) {
      setState(() {
        if (selectedFilter[currentSelected]!.contains(key)) {
          selectedFilter[currentSelected]!.remove(key);
        } else {
          selectedFilter[currentSelected]!.add(key);
        }
      });
    }
  }

  bool isMainFilterSelected(String key) {
    if (selectedFilter.containsKey(key)) {
      return selectedFilter[key]!.isNotEmpty;
    }
    return false;
  }

  bool isMinnorFilterSelected(String key) {
    if (selectedFilter.containsKey(currentSelected)) {
      return selectedFilter[currentSelected]!.contains(key);
    }
    return false;
  }

  int numberMinnorTagSelected(String key) {
    if (selectedFilter.containsKey(key)) {
      return selectedFilter[key]!.length;
    }
    return 0;
  }

  String currentSelected = 'default';

  void selectMainFilter(String key) {
    setState(() {
      currentSelected = key;
    });
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_scrollListener);
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
          physics: const BouncingScrollPhysics(),
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
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              color: AdaptiveTheme.of(context).mode.isDark
                                  ? Colors.white.withOpacity(0.05)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search for a question set',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AdaptiveTheme.of(context).mode.isDark
                                      ? Colors.white.withOpacity(0.5)
                                      : Colors.black.withOpacity(0.5),
                                ),
                                border: InputBorder.none,
                                alignLabelWithHint: true,
                                contentPadding:
                                    const EdgeInsets.only(bottom: 4),
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
                        ]),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AdaptiveTheme.of(context).mode.isDark
                            ? Colors.white.withOpacity(0.05)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Text(
                                  'Filters',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AdaptiveTheme.of(context).mode.isDark
                                        ? Colors.white.withOpacity(0.8)
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  if (currentSelected != 'default') {
                                    selectMainFilter('default');
                                  } else {
                                    selectMainFilter('Course');
                                  }
                                },
                                child: Icon(
                                  currentSelected == 'default'
                                      ? Icons
                                          .keyboard_double_arrow_down_outlined
                                      : Icons.keyboard_double_arrow_up_outlined,
                                  size: 30,
                                  color: AdaptiveTheme.of(context).mode.isDark
                                      ? Colors.white.withOpacity(0.5)
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: AdaptiveTheme.of(context).mode.isDark
                                ? Colors.white.withOpacity(0.1)
                                : Colors.black.withOpacity(0.1),
                            thickness: 1,
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 44,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: mainFilter.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () =>
                                      selectMainFilter(mainFilter[index]),
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    margin: EdgeInsets.only(
                                        right: index == mainFilter.length - 1
                                            ? 0
                                            : 10),
                                    decoration: BoxDecoration(
                                      color:
                                          AdaptiveTheme.of(context).mode.isDark
                                              ? Colors.white.withOpacity(0.05)
                                              : isMainFilterSelected(
                                                      mainFilter[index])
                                                  ? const Color.fromARGB(
                                                      255, 0, 69, 104)
                                                  : Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: AdaptiveTheme.of(context)
                                                .mode
                                                .isDark
                                            ? Colors.white.withOpacity(0.05)
                                            : const Color.fromARGB(
                                                255,
                                                0,
                                                69,
                                                104,
                                              ),
                                      ),
                                    ),
                                    child: Text(
                                      numberMinnorTagSelected(
                                                  mainFilter[index]) ==
                                              0
                                          ? mainFilter[index]
                                          : '${mainFilter[index]} +${numberMinnorTagSelected(mainFilter[index])}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AdaptiveTheme.of(context)
                                                .mode
                                                .isDark
                                            ? isMainFilterSelected(
                                                    mainFilter[index])
                                                ? Colors.white.withOpacity(0.8)
                                                : Colors.white.withOpacity(0.5)
                                            : isMainFilterSelected(
                                                    mainFilter[index])
                                                ? Colors.white
                                                : const Color.fromARGB(
                                                    255, 0, 69, 104),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            children: [
                              for (int index = 0;
                                  index < minorFilter[currentSelected]!.length;
                                  index++)
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0.7,
                                    backgroundColor: AdaptiveTheme.of(context)
                                            .mode
                                            .isDark
                                        ? isMinnorFilterSelected(minorFilter[
                                                currentSelected]![index])
                                            ? Colors.white.withOpacity(0.05)
                                            : Colors.white.withOpacity(0.05)
                                        : isMinnorFilterSelected(minorFilter[
                                                currentSelected]![index])
                                            ? const Color.fromARGB(
                                                255, 232, 235, 240)
                                            : Colors.white,
                                    surfaceTintColor: Colors.white,
                                    foregroundColor: AdaptiveTheme.of(context)
                                            .mode
                                            .isDark
                                        ? isMinnorFilterSelected(minorFilter[
                                                currentSelected]![index])
                                            ? Colors.white.withOpacity(0.8)
                                            : Colors.white.withOpacity(0.5)
                                        : const Color.fromARGB(255, 0, 69, 104),
                                  ),
                                  child: Text(
                                      minorFilter[currentSelected]![index]),
                                  onPressed: () {
                                    selectMinorFilter(
                                        minorFilter[currentSelected]![index]);
                                  },
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 50,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 0),
                                margin: const EdgeInsets.only(right: 10),
                                width: MediaQuery.of(context).size.width * 0.75,
                                decoration: BoxDecoration(
                                  color: AdaptiveTheme.of(context).mode.isDark
                                      ? Colors.white.withOpacity(0.05)
                                      : const Color.fromRGBO(244, 247, 252, 1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                    hintText: 'Amount of questions',
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          AdaptiveTheme.of(context).mode.isDark
                                              ? Colors.white.withOpacity(0.5)
                                              : Colors.black.withOpacity(0.5),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.only(bottom: 4),
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
                                  child: Icon(
                                    Icons.shuffle_outlined,
                                    size: 25,
                                    color: AdaptiveTheme.of(context).mode.isDark
                                        ? Colors.white.withOpacity(0.5)
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: AdaptiveTheme.of(context).mode.isDark
                            ? Colors.white.withOpacity(0.05)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    'Question Sets',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          AdaptiveTheme.of(context).mode.isDark
                                              ? Colors.white.withOpacity(0.8)
                                              : Colors.black,
                                    ),
                                  ),
                                ),
                                const Spacer(),
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: Divider(
                              color: AdaptiveTheme.of(context).mode.isDark
                                  ? Colors.white.withOpacity(0.1)
                                  : Colors.black.withOpacity(0.1),
                              thickness: 1,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            height: MediaQuery.of(context).size.height * 0.53,
                            child: ListView.builder(
                              shrinkWrap: true,
                              controller: _scrollController,
                              scrollDirection: Axis.vertical,
                              itemCount: 20,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin:
                                      EdgeInsets.only(top: index != 0 ? 8 : 0),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AdaptiveTheme.of(context).mode.isDark
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
                                                  '2021 UEE Chemistry',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AdaptiveTheme
                                                                .of(context)
                                                            .mode
                                                            .isDark
                                                        ? Colors.white
                                                            .withOpacity(0.8)
                                                        : Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '100 Questions',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: AdaptiveTheme
                                                                .of(context)
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
                                                ? Colors.white.withOpacity(0.08)
                                                : const Color.fromARGB(
                                                    255, 0, 69, 104),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            index % 2 == 0 ? 'Take' : 'Retake',
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
