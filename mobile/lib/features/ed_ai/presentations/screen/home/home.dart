import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/ed_ai/presentations/bloc/problem/problem_bloc.dart';
import 'package:mobile/features/ed_ai/presentations/bloc/scroll/scroll_bloc.dart';

const image =
    "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";

class Home extends StatefulWidget {
  const Home({super.key});

  static const routeName = '/contest/home';

  @override
  State<Home> createState() => _ContestInfoState();
}

class _ContestInfoState extends State<Home> {
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
    context.read<ProblemBloc>().add(const GetLastUpdate());
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
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
          scrollDirection: Axis.vertical,
          child: BlocListener<ProblemBloc, ProblemState>(
            listener: (context, state) {
              var dateTime = DateTime(2021, 1, 1);
              if (state.lastUpdatedProblemStatus ==
                      LastUpdatedProblemStatus.success ||
                  state.lastUpdatedProblemStatus ==
                      LastUpdatedProblemStatus.failure) {
                if (state.syncfetch) {
                  context.read<ProblemBloc>().add(SyncProblem(
                        lastUpdated: LastUpdatedProblemStatus.success ==
                                state.lastUpdatedProblemStatus
                            ? state.lastUpdatedProblem?.updatedAt ?? dateTime
                            : dateTime,
                        skip: state.problemsToSync.length,
                      ));
                }
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Well Come',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AdaptiveTheme.of(context).mode.isDark
                                ? Colors.white.withOpacity(0.8)
                                : Colors.black.withOpacity(0.4),
                          ),
                        ),
                        Text(
                          'Nafiu Ibrahim',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AdaptiveTheme.of(context).mode.isDark
                                ? Colors.white.withOpacity(0.8)
                                : const Color.fromARGB(255, 0, 69, 104),
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Container(
                        clipBehavior: Clip.hardEdge,
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                        ))
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.27,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AdaptiveTheme.of(context).mode.isDark
                        ? Colors.white.withOpacity(0.05)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
