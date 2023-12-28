import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/ed_ai/presentations/bloc/problem/problem_bloc.dart';
import 'package:mobile/injection_container.dart';

class GuideHome extends StatefulWidget {
  const GuideHome({super.key});

  @override
  State<GuideHome> createState() => _GuideHomeState();
}

class _GuideHomeState extends State<GuideHome> {
  late ProblemBloc _problemBloc;

  @override
  void initState() {
    super.initState();
    _problemBloc = sl<ProblemBloc>();

    _problemBloc.add(const GetProblems());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _problemBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Guide Home'),
        ),
        body: Center(
          child: BlocBuilder<ProblemBloc, ProblemState>(
            builder: (context, state) {
              if (state.fetchProblemsStatus == FetchProblemsStatus.loading) {
                return const CircularProgressIndicator();
              } else if (state.fetchProblemsStatus ==
                  FetchProblemsStatus.failure) {
                return const Text('Error');
              } else if (state.fetchProblemsStatus ==
                  FetchProblemsStatus.success) {
                return ListView.builder(
                  itemCount: state.problems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.problems[index].id),
                    );
                  },
                );
              }
              return Text('Guide Home ${state.problems.length}');
            },
          ),
        ),
      ),
    );
  }
}
