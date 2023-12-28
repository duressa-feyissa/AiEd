part of 'problem_bloc.dart';

enum FetchProblemsStatus {
  initial,
  loading,
  success,
  failure,
}

enum FetchProblemStatus {
  initial,
  loading,
  success,
  failure,
}

class ProblemState extends Equatable {
  final FetchProblemStatus fetchProblemStatus;
  final FetchProblemsStatus fetchProblemsStatus;
  final List<Problem> problems;
  final Problem? problem;

  const ProblemState({
    this.fetchProblemStatus = FetchProblemStatus.initial,
    this.fetchProblemsStatus = FetchProblemsStatus.initial,
    this.problems = const [],
    this.problem,
  });

  @override
  List<Object> get props => [
        fetchProblemStatus,
        fetchProblemsStatus,
        problems,
      ];

  ProblemState copyWith({
    FetchProblemStatus? fetchProblemStatus,
    FetchProblemsStatus? fetchProblemsStatus,
    List<Problem>? problems,
    Problem? problem,
  }) {
    return ProblemState(
      fetchProblemStatus: fetchProblemStatus ?? this.fetchProblemStatus,
      fetchProblemsStatus: fetchProblemsStatus ?? this.fetchProblemsStatus,
      problems: problems ?? this.problems,
      problem: problem ?? this.problem,
    );
  }
}
