part of 'problem_bloc.dart';

sealed class ProblemEvent extends Equatable {
  const ProblemEvent();

  @override
  List<Object> get props => [];
}

class GetProblems extends ProblemEvent {
  final String? source;
  final String? value;
  final int? year;
  final String? target;
  final String? courses;
  final String? difficulty;
  final String? topic;
  final String? grade;
  final String? unit;

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
