import 'package:either_dart/either.dart';
import 'package:mobile/core/errors/failure.dart';
import 'package:mobile/features/ed_ai/domains/entities/auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, Auth>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, Auth>> getAuth();
  Future<Either<Failure, bool>> checkAuth();
  Future<Either<Failure, void>> deleteAuth();
}
