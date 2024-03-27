import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/errors/failure.dart';
import 'package:mobile/core/use_cases/usecase.dart';
import 'package:mobile/features/ed_ai/domains/entities/user.dart';
import 'package:mobile/features/ed_ai/domains/repositories/user.dart';

class DeleteUser extends UseCase<User, Params> {
  final UserRepository repository;

  DeleteUser(this.repository);

  @override
  Future<Either<Failure, User>> call(Params params) async {
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
