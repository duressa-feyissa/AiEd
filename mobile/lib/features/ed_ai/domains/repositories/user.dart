import 'package:either_dart/either.dart';
import 'package:mobile/core/errors/failure.dart';
import 'package:mobile/features/ed_ai/domains/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> findById({required String id});
  Future<Either<Failure, User>> create({
    required String firstName,
    required String lastName,
    required String username,
    required String phone,
    required String password,
    required String role,
  });
  Future<Either<Failure, User>> update({
    String? firstName,
    String? lastName,
    String? username,
    String? phone,
    String? password,
  });

  Future<Either<Failure, User>> delete({required String id});
  Future<Either<Failure, User>> findByPhone({required String phone});
  Future<Either<Failure, User>> findByUsername({required String username});
  Future<Either<Failure, User>> me();
}
