

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/errors/failure.dart';
import 'package:mobile/core/use_cases/usecase.dart';
import 'package:mobile/features/ed_ai/domains/entities/problem.dart';
import 'package:mobile/features/ed_ai/domains/repositories/problem.dart';


class SyncProblem extends UseCase<List<Problem>, Params> {
  final ProblemRepository repository;

  SyncProblem(this.repository);

  @override
  Future<Either<Failure, List<Problem>>> call(Params params) async {
    return await repository.syncProblem(lastUpdated: params.lastUpdated, skip: params.skip, limit: params.limit);
  }
}

class Params extends Equatable {
   final   DateTime lastUpdated;
    final int? skip;
    final int? limit;

  const Params({
    required this.lastUpdated,
    required this.skip,
    required this.limit,
  });

  @override
  List<Object?> get props => [lastUpdated, skip, limit];
}