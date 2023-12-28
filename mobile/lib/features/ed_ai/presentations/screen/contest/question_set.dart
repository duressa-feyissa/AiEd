import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/scroll/scroll_bloc.dart';

class QuestionSet extends StatefulWidget {
  const QuestionSet({Key? key}) : super(key: key);

  static const routeName = '/contest/question-set';

  @override
  State<QuestionSet> createState() => _QuestionSetState();
}

class _QuestionSetState extends State<QuestionSet> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdaptiveTheme.of(context).mode.isDark
          ? const Color.fromRGBO(28, 27, 32, 1)
          : const Color.fromARGB(255, 0, 69, 104),
      body: SafeArea(
        child: Column(
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
                            onTap: () {
                              BlocProvider.of<ScrollBloc>(context)
                                  .add(ToggleVisibilityEvent(isVisible: false));
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_outlined,
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
                          Icons.filter_list_outlined,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Solve 34/100',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 16,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '00:20:01',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
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
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.005),
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
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 0.2,
                        child: ListTile(
                          title: Text(
                            'Question ${index + 1}',
                            style: TextStyle(
                                color: AdaptiveTheme.of(context).mode.isDark
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          trailing: index % 4 == 0
                              ? const Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.green,
                                )
                              : index % 2 == 0
                                  ? const Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.red,
                                    )
                                  : const Icon(
                                      //want icon not done
                                      Icons.circle_outlined,
                                      color: Colors.grey,
                                    ),
                          onTap: () {
                            // Handle tapping on a question
                          },
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
