import 'package:either_dart/either.dart';
import 'package:mobile/core/errors/failure.dart';
import 'package:mobile/features/ed_ai/domains/entities/problem.dart';

abstract class ProblemRepository {
  Future<Either<Failure, Problem>> getById({
    required String id,
  });
  Future<Either<Failure, List<Problem>>> list({
    String? source,
    String? value,
    int? year,
    String? target,
    String? courses,
    String? difficulty,
    String? topic,
    String? grade,
  });
}
