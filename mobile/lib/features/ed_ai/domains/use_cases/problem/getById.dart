import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/errors/failure.dart';
import 'package:mobile/core/use_cases/usecase.dart';
import 'package:mobile/features/ed_ai/domains/entities/problem.dart';
import 'package:mobile/features/ed_ai/domains/repositories/problem.dart';

class ProblemGetById extends UseCase<Problem, Params> {
  final ProblemRepository repository;

  ProblemGetById(this.repository);

  @override
  Future<Either<Failure, Problem>> call(Params params) async {
    return await repository.getById(
      id: params.id,
    );
  }
}

class Params extends Equatable {
  final String id;

  const Params({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
