part of 'problem_bloc.dart';

sealed class ProblemEvent extends Equatable {
  const ProblemEvent();

  @override
  List<Object> get props => [];
}

class DeleteProblem extends ProblemEvent {
  final String id;

  const DeleteProblem({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class GetProblems extends ProblemEvent {
  final List<String>? source;
  final List<String>? value;
  final List<int>? year;
  final List<String>? target;
  final List<String>? courses;
  final List<String>? difficulty;
  final List<String>? topic;
  final List<String>? grade;
  final List<String>? unit;

  const GetProblems({
    this.source,
    this.value,
    this.year,
    this.target,
    this.courses,
    this.difficulty,
    this.topic,
    this.grade,
    this.unit,
  });

  @override
  List<Object> get props => [
        source ?? '',
        value ?? '',
        year ?? 0,
        target ?? '',
        courses ?? '',
        difficulty ?? '',
        topic ?? '',
        grade ?? '',
        unit ?? '',
      ];
}

class GetProblem extends ProblemEvent {
  final String id;

  const GetProblem({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class GetLastUpdate extends ProblemEvent {
  const GetLastUpdate();
}

class SyncProblem extends ProblemEvent {
  final DateTime lastUpdated;
  final int? skip;
  final int? limit;

  const SyncProblem({
    required this.lastUpdated,
    this.skip = 0,
    this.limit = 1,
  });

  @override
  List<Object> get props => [lastUpdated, skip ?? 0, limit ?? 1];
}
