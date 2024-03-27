import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/errors/failure.dart';
import 'package:mobile/core/use_cases/usecase.dart';
import 'package:mobile/features/ed_ai/domains/entities/user.dart';
import 'package:mobile/features/ed_ai/domains/repositories/user.dart';

class CreateUser extends UseCase<User, Params> {
  final UserRepository repository;

  CreateUser(this.repository);

  @override
  Future<Either<Failure, User>> call(Params params) async {
    return await repository.create(
      firstName: params.firstName,
      lastName: params.lastName,
      username: params.username,
      phone: params.phone,
      password: params.password,
      role: params.role,
    );
  }
}

class Params extends Equatable {
  final String firstName;
  final String lastName;
  final String username;
  final String phone;
  final String password;
  final String role;

  const Params({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.phone,
    required this.password,
    required this.role,
  });

  @override
  List<Object> get props =>
      [firstName, lastName, username, phone, password, role];
}
