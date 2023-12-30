import 'package:either_dart/either.dart';
import 'package:mobile/core/errors/failure.dart';
import 'package:mobile/core/use_cases/usecase.dart';
import 'package:mobile/features/ed_ai/domains/entities/problem.dart';
import 'package:mobile/features/ed_ai/domains/repositories/problem.dart';

class LastUpdatedProblem extends UseCase<Problem, NoParams> {
  final ProblemRepository repository;

  LastUpdatedProblem(this.repository);

  @override
  Future<Either<Failure, Problem>> call(NoParams params) async {
    return await repository.lastUpdate();
  }
}
