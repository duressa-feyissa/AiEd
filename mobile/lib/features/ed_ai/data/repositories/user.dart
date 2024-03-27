import 'package:either_dart/either.dart';
import 'package:mobile/core/errors/failure.dart';
import 'package:mobile/core/network/info.dart';
import 'package:mobile/features/ed_ai/data/datasources/local/user.dart';
import 'package:mobile/features/ed_ai/data/datasources/remote/user.dart';
import 'package:mobile/features/ed_ai/domains/entities/user.dart';
import 'package:mobile/features/ed_ai/domains/repositories/user.dart';

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final UserLocalDataSource localDataSource;
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, User>> create(
      {required String firstName,
      required String lastName,
      required String username,
      required String phone,
      required String password,
      required String role}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> delete({required String id}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> findById({required String id}) {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> findByPhone({required String phone}) {
    // TODO: implement findByPhone
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> findByUsername({required String username}) {
    // TODO: implement findByUsername
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> me() {
    // TODO: implement me
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> update(
      {String? firstName,
      String? lastName,
      String? username,
      String? phone,
      String? password}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
