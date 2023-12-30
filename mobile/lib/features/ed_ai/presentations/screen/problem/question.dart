import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latext/latext.dart';
import 'package:mobile/features/ed_ai/presentations/bloc/problem/problem_bloc.dart';
import 'package:mobile/features/ed_ai/presentations/bloc/scroll/scroll_bloc.dart';
import 'package:mobile/features/ed_ai/presentations/screen/contest/question_set.dart';
import 'package:mobile/features/ed_ai/presentations/screen/contest/standing.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Question extends StatefulWidget {
  const Question({
    Key? key,
  }) : super(key: key);

  static const routeName = '/problem/question';

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ScrollBloc>(context)
        .add(ToggleVisibilityEvent(isVisible: false));
  }

  void barColor() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
    );
  }

  @override
  Widget build(BuildContext context) {
    barColor();

    return Scaffold(
      backgroundColor: AdaptiveTheme.of(context).mode.isDark
          ? const Color.fromRGBO(28, 27, 32, 1)
          : const Color.fromARGB(255, 0, 69, 104),
      body: SafeArea(
        child: BlocBuilder<ProblemBloc, ProblemState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back_rounded,
                                  size: 40,
                                  color: AdaptiveTheme.of(context).mode.isDark
                                      ? Colors.white.withOpacity(0.8)
                                      : Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor:
                                        AdaptiveTheme.of(context).mode.isDark
                                            ? Colors.white.withOpacity(0.8)
                                            : Colors.white,
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
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: AdaptiveTheme.of(context)
                                                    .mode
                                                    .isDark
                                                ? Colors.white.withOpacity(0.8)
                                                : Colors.white,
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
                                                : Colors.white,
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
                                settings: const RouteSettings(
                                    name: '/contest/standing'),
                                screen: const ContestStanding(),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                              barColor();
                            },
                            child: Icon(
                              Icons.leaderboard_rounded,
                              size: 35,
                              color: AdaptiveTheme.of(context).mode.isDark
                                  ? Colors.white.withOpacity(0.8)
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await PersistentNavBarNavigator
                                      .pushNewScreenWithRouteSettings(
                                    context,
                                    settings: const RouteSettings(
                                        name: '/contest/question-set'),
                                    screen: const QuestionSet(),
                                    withNavBar: true,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                  barColor();
                                },
                                child: Icon(
                                  Icons.list_alt_rounded,
                                  size: 30,
                                  color: AdaptiveTheme.of(context).mode.isDark
                                      ? Colors.white.withOpacity(0.8)
                                      : Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Question 4/100',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AdaptiveTheme.of(context).mode.isDark
                                      ? Colors.white.withOpacity(0.8)
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                size: 16,
                                color: AdaptiveTheme.of(context).mode.isDark
                                    ? Colors.white.withOpacity(0.8)
                                    : Colors.white,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                '00:20:01',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AdaptiveTheme.of(context).mode.isDark
                                      ? Colors.white.withOpacity(0.8)
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AdaptiveTheme.of(context).mode.isDark
                          ? Colors.white.withOpacity(0.03)
                          : const Color.fromARGB(255, 237, 246, 250),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    clipBehavior: Clip.hardEdge,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              Column(
                                children: state.problems[2].question
                                    .map(
                                      (question) => Builder(
                                        builder: (context) => LaTexT(
                                          laTeXCode: Text(
                                            question.value,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: AdaptiveTheme.of(context)
                                                      .mode
                                                      .isDark
                                                  ? Colors.white
                                                      .withOpacity(0.8)
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                              color: AdaptiveTheme.of(context)
                                                      .mode
                                                      .isDark
                                                  ? Colors.white
                                                      .withOpacity(0.8)
                                                  : const Color.fromARGB(
                                                      255, 0, 69, 104),
                                              width: 1,
                                            ),
                                          ),
                                          child: Text(
                                            'A',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: AdaptiveTheme.of(context)
                                                      .mode
                                                      .isDark
                                                  ? Colors.white
                                                      .withOpacity(0.8)
                                                  : const Color.fromARGB(
                                                      255, 0, 69, 104),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(state.problems[2].answer.type ==
                                                'options'
                                            ? state.problems[2].answer.option
                                                .toString()
                                            : 'dd'),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                              color: AdaptiveTheme.of(context)
                                                      .mode
                                                      .isDark
                                                  ? Colors.white
                                                      .withOpacity(0.8)
                                                  : const Color.fromARGB(
                                                      255, 0, 69, 104),
                                              width: 1,
                                            ),
                                          ),
                                          child: Text(
                                            'B',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: AdaptiveTheme.of(context)
                                                      .mode
                                                      .isDark
                                                  ? Colors.white
                                                      .withOpacity(0.8)
                                                  : const Color.fromARGB(
                                                      255, 0, 69, 104),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: Text(
                                            'Break down the cell after it dies',
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: AdaptiveTheme.of(context)
                                                      .mode
                                                      .isDark
                                                  ? Colors.white
                                                      .withOpacity(0.8)
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: AdaptiveTheme.of(context)
                                                    .mode
                                                    .isDark
                                                ? const Color.fromRGBO(
                                                    28, 27, 32, 1)
                                                : const Color.fromARGB(
                                                    255, 0, 69, 104),
                                            border: Border.all(
                                              color: AdaptiveTheme.of(context)
                                                      .mode
                                                      .isDark
                                                  ? Colors.white
                                                      .withOpacity(0.1)
                                                  : const Color.fromARGB(
                                                      255, 0, 69, 104),
                                              width: 1,
                                            ),
                                          ),
                                          child: Text(
                                            'C',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: AdaptiveTheme.of(context)
                                                      .mode
                                                      .isDark
                                                  ? Colors.white
                                                      .withOpacity(0.8)
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: Text(
                                            'Break down the cell after it dies',
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: AdaptiveTheme.of(context)
                                                      .mode
                                                      .isDark
                                                  ? Colors.white
                                                      .withOpacity(0.8)
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                              color: AdaptiveTheme.of(context)
                                                      .mode
                                                      .isDark
                                                  ? Colors.white
                                                      .withOpacity(0.8)
                                                  : const Color.fromARGB(
                                                      255, 0, 69, 104),
                                              width: 1,
                                            ),
                                          ),
                                          child: Text(
                                            'D',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: AdaptiveTheme.of(context)
                                                      .mode
                                                      .isDark
                                                  ? Colors.white
                                                      .withOpacity(0.8)
                                                  : const Color.fromARGB(
                                                      255, 0, 69, 104),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: Text(
                                            'Break down the cell after it dies',
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: AdaptiveTheme.of(context)
                                                      .mode
                                                      .isDark
                                                  ? Colors.white
                                                      .withOpacity(0.8)
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          child: SizedBox(
                            height: 35,
                            child: ListView.builder(
                              itemCount: state.problems.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 9),
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: (index % 7 == 0 || index % 3 == 0)
                                        ? AdaptiveTheme.of(context).mode.isDark
                                            ? const Color.fromRGBO(
                                                28, 27, 32, 1)
                                            : const Color.fromARGB(
                                                255, 0, 69, 104)
                                        : AdaptiveTheme.of(context).mode.isDark
                                            ? Colors.transparent
                                            : Colors.white.withOpacity(0.8),
                                    border: Border.all(
                                      color: (index % 7 == 0 || index % 3 == 0)
                                          ? AdaptiveTheme.of(context)
                                                  .mode
                                                  .isDark
                                              ? Colors.white.withOpacity(0.1)
                                              : const Color.fromARGB(
                                                  255, 0, 69, 104)
                                          : AdaptiveTheme.of(context)
                                                  .mode
                                                  .isDark
                                              ? Colors.white.withOpacity(0.8)
                                              : const Color.fromARGB(
                                                  255, 0, 69, 104),
                                      width: 1,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: (index % 7 == 0 || index % 3 == 0)
                                          ? AdaptiveTheme.of(context)
                                                  .mode
                                                  .isDark
                                              ? Colors.white.withOpacity(0.8)
                                              : Colors.white
                                          : AdaptiveTheme.of(context)
                                                  .mode
                                                  .isDark
                                              ? Colors.white.withOpacity(0.8)
                                              : const Color.fromARGB(
                                                  255, 0, 69, 104),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
