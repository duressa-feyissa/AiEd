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

enum DeleteProblemStatus {
  initial,
  loading,
  success,
  failure,
}

enum LastUpdatedProblemStatus {
  initial,
  loading,
  success,
  failure,
}

enum SyncProblemStatus {
  initial,
  loading,
  success,
  failure,
}

class ProblemState extends Equatable {
  final FetchProblemStatus fetchProblemStatus;
  final FetchProblemsStatus fetchProblemsStatus;
  final DeleteProblemStatus deleteProblemStatus;
  final LastUpdatedProblemStatus lastUpdatedProblemStatus;
  final SyncProblemStatus syncProblemStatus;
  final List<Problem> problems;
  final Problem? problem;
  final Problem? lastUpdatedProblem;
  final List<Problem> problemsToSync;
  final bool syncfetch;

  const ProblemState({
    this.deleteProblemStatus = DeleteProblemStatus.initial,
    this.fetchProblemStatus = FetchProblemStatus.initial,
    this.fetchProblemsStatus = FetchProblemsStatus.initial,
    this.lastUpdatedProblemStatus = LastUpdatedProblemStatus.initial,
    this.syncProblemStatus = SyncProblemStatus.initial,
    this.problems = const [],
    this.problemsToSync = const [],
    this.problem,
    this.lastUpdatedProblem,
    this.syncfetch = true,
  });

  @override
  List<Object> get props => [
        fetchProblemStatus,
        fetchProblemsStatus,
        deleteProblemStatus,
        problems,
        lastUpdatedProblemStatus,
        syncProblemStatus,
        problemsToSync,
        syncfetch,
      ];

  ProblemState copyWith({
    DeleteProblemStatus? deleteProblemStatus,
    FetchProblemStatus? fetchProblemStatus,
    FetchProblemsStatus? fetchProblemsStatus,
    LastUpdatedProblemStatus? lastUpdatedProblemStatus,
    SyncProblemStatus? syncProblemStatus,
    List<Problem>? problems,
    Problem? problem,
    Problem? lastUpdatedProblem,
    List<Problem>? problemsToSync,
    bool? syncfetch,
  }) {
    return ProblemState(
      deleteProblemStatus: deleteProblemStatus ?? this.deleteProblemStatus,
      fetchProblemStatus: fetchProblemStatus ?? this.fetchProblemStatus,
      fetchProblemsStatus: fetchProblemsStatus ?? this.fetchProblemsStatus,
      syncProblemStatus: syncProblemStatus ?? this.syncProblemStatus,
      lastUpdatedProblemStatus:
          lastUpdatedProblemStatus ?? this.lastUpdatedProblemStatus,
      problems: problems ?? this.problems,
      problem: problem ?? this.problem,
      lastUpdatedProblem: lastUpdatedProblem ?? this.lastUpdatedProblem,
      problemsToSync: problemsToSync ?? this.problemsToSync,
      syncfetch: syncfetch ?? this.syncfetch,
    );
  }
}
