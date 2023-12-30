import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/errors/failure.dart';
import 'package:mobile/core/use_cases/usecase.dart';
import 'package:mobile/features/ed_ai/domains/repositories/problem.dart';

class DeleteProblem extends UseCase<String, Params> {
  final ProblemRepository repository;

  DeleteProblem(this.repository);

  @override
  Future<Either<Failure, String>> call(Params params) async {
    return await repository.delete(
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
