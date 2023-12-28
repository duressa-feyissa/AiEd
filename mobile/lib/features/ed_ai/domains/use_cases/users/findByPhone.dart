import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/errors/failure.dart';
import 'package:mobile/core/use_cases/usecase.dart';
import 'package:mobile/features/ed_ai/domains/entities/user.dart';
import 'package:mobile/features/ed_ai/domains/repositories/user.dart';

class FindUserByPhone extends UseCase<User, Params> {
  final UserRepository repository;

  FindUserByPhone(this.repository);

  @override
  Future<Either<Failure, User>> call(Params params) async {
    return await repository.findByPhone(
      phone: params.phone,
    );
  }
}

class Params extends Equatable {
  final String phone;

  const Params({
    required this.phone,
  });

  @override
  List<Object> get props => [phone];
}
