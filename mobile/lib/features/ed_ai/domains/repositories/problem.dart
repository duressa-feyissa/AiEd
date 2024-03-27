import 'package:either_dart/either.dart';
import 'package:mobile/core/errors/failure.dart';
import 'package:mobile/features/ed_ai/domains/entities/problem.dart';

abstract class ProblemRepository {
  Future<Either<Failure, Problem>> getById({
    required String id,
  });
  Future<Either<Failure, List<Problem>>> list({
    List<String>? source,
    List<String>? value,
    List<int>? year,
    List<String>? target,
    List<String>? courses,
    List<String>? difficulty,
    List<String>? topic,
    List<String>? grade,
  });
  Future<Either<Failure, String>> delete({
    required String id,
  });
  Future<Either<Failure, Problem>> lastUpdate();

  Future<Either<Failure, List<Problem>>> syncProblem(
      {required DateTime lastUpdated, int? skip, int? limit});
}
