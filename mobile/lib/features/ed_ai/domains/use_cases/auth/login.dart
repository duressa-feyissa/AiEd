import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/errors/failure.dart';
import 'package:mobile/core/use_cases/usecase.dart';
import 'package:mobile/features/ed_ai/domains/entities/auth.dart';
import 'package:mobile/features/ed_ai/domains/repositories/auth.dart';

class Login extends UseCase<Auth, Params> {
  final AuthRepository repository;

  Login(this.repository);

  @override
  Future<Either<Failure, Auth>> call(Params params) async {
    return await repository.login(
        email: params.email, password: params.password);
  }
}

class Params extends Equatable {
  final String email;
  final String password;

  const Params({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
