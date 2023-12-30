import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/errors/failure.dart';
import 'package:mobile/core/use_cases/usecase.dart';
import 'package:mobile/features/ed_ai/domains/entities/problem.dart';
import 'package:mobile/features/ed_ai/domains/repositories/problem.dart';

class ListProblem extends UseCase<List<Problem>, Params> {
  final ProblemRepository repository;

  ListProblem(this.repository);

  @override
  Future<Either<Failure, List<Problem>>> call(Params params) async {
    return await repository.list(
        target: params.target,
        source: params.source,
        value: params.value,
        year: params.year,
        courses: params.courses,
        difficulty: params.difficulty,
        topic: params.topic,
        grade: params.grade);
  }
}

class Params extends Equatable {
  final List<String>? source;
  final List<String>? value;
  final List<int>? year;
  final List<String>? target;
  final List<String>? courses;
  final List<String>? difficulty;
  final List<String>? topic;
  final List<String>? grade;

  const Params({
    required this.source,
    required this.value,
    required this.year,
    required this.target,
    required this.courses,
    required this.difficulty,
    required this.topic,
    required this.grade,
  });

  @override
  List<Object?> get props =>
      [source, value, year, target, courses, difficulty, topic, grade];
}
