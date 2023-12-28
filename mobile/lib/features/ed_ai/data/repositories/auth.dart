import 'package:either_dart/either.dart';
import 'package:mobile/core/errors/exception.dart';
import 'package:mobile/core/errors/failure.dart';
import 'package:mobile/core/network/info.dart';
import 'package:mobile/features/ed_ai/data/datasources/local/auth.dart';
import 'package:mobile/features/ed_ai/data/datasources/remote/auth.dart';
import 'package:mobile/features/ed_ai/domains/entities/auth.dart';
import 'package:mobile/features/ed_ai/domains/repositories/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
    required this.sharedPreferences,
  });

  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final SharedPreferences sharedPreferences;

  @override
  Future<Either<Failure, bool>> checkAuth() async {
    try {
      final auth = await localDataSource.isValidToken();
      if (auth) {
        return Right(auth);
      } else {
        return Left(CacheFailure());
      }
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteAuth() async {
    try {
      await localDataSource.deleteToken();
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Auth>> getAuth() async {
    try {
      final auth = await localDataSource.getToken();
      return Right(auth);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Auth>> login(
      {required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final auth =
            await remoteDataSource.login(email: email, password: password);
        await localDataSource.cacheToken(auth: auth);
        return Right(auth);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
