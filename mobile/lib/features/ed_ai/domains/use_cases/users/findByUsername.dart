import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/errors/failure.dart';
import 'package:mobile/core/use_cases/usecase.dart';
import 'package:mobile/features/ed_ai/domains/entities/user.dart';
import 'package:mobile/features/ed_ai/domains/repositories/user.dart';

class FindUserByUsername extends UseCase<User, Params> {
  final UserRepository repository;

  FindUserByUsername(this.repository);

  @override
  Future<Either<Failure, User>> call(Params params) async {
    return await repository.findByUsername(
      username: params.username,
    );
  }
}

class Params extends Equatable {
  final String username;

  const Params({
    required this.username,
  });

  @override
  List<Object> get props => [username];
}
