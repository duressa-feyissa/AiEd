import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/ed_ai/presentations/bloc/problem/problem_bloc.dart';

class GuideHome extends StatefulWidget {
  const GuideHome({super.key});

  @override
  State<GuideHome> createState() => _GuideHomeState();
}

class _GuideHomeState extends State<GuideHome> {
  @override
  void initState() {
    super.initState();
    context.read<ProblemBloc>().add(const GetProblems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            } else {
              return ListView.builder(
                itemCount: state.problems.length,
                itemBuilder: (context, index) {
                  print(state.problems.length);

                  return GestureDetector(
                    onDoubleTap: () {
                      setState(() {
                        context
                            .read<ProblemBloc>()
                            .add(DeleteProblem(id: state.problems[index].id));
                      });
                    },
                    child: ListTile(
                      title: Text(state.problems[index].id),
                      subtitle:
                          Text(state.problems[index].updatedAt.toString()),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
