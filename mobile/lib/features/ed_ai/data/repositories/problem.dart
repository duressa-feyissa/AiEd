import 'package:either_dart/either.dart';
import 'package:mobile/core/errors/exception.dart';
import 'package:mobile/core/errors/failure.dart';
import 'package:mobile/core/network/info.dart';
import 'package:mobile/features/ed_ai/data/datasources/local/problem.dart';
import 'package:mobile/features/ed_ai/data/datasources/remote/problem.dart';
import 'package:mobile/features/ed_ai/domains/entities/problem.dart';
import 'package:mobile/features/ed_ai/domains/repositories/problem.dart';

const String token =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyIkX18iOnsiYWN0aXZlUGF0aHMiOnsicGF0aHMiOnsiZW1haWwiOiJpbml0Iiwicm9sZSI6ImluaXQiLCJ2ZXJpZnkiOiJpbml0IiwicG9pbnRzIjoiaW5pdCIsIl9pZCI6ImluaXQiLCJmaXJzdE5hbWUiOiJpbml0IiwibGFzdE5hbWUiOiJpbml0IiwicGhvbmUiOiJpbml0IiwicGFzc3dvcmQiOiJpbml0IiwiZGF0ZU9mQmlydGgiOiJpbml0Iiwic2Nob29sIjoiaW5pdCIsImdyYWRlIjoiaW5pdCIsImNyZWF0ZWRBdCI6ImluaXQiLCJfX3YiOiJpbml0In0sInN0YXRlcyI6eyJyZXF1aXJlIjp7fSwiZGVmYXVsdCI6e30sImluaXQiOnsiX2lkIjp0cnVlLCJmaXJzdE5hbWUiOnRydWUsImxhc3ROYW1lIjp0cnVlLCJwaG9uZSI6dHJ1ZSwiZW1haWwiOnRydWUsInBhc3N3b3JkIjp0cnVlLCJyb2xlIjp0cnVlLCJ2ZXJpZnkiOnRydWUsImRhdGVPZkJpcnRoIjp0cnVlLCJzY2hvb2wiOnRydWUsImdyYWRlIjp0cnVlLCJwb2ludHMiOnRydWUsImNyZWF0ZWRBdCI6dHJ1ZSwiX192Ijp0cnVlfX19LCJza2lwSWQiOnRydWV9LCIkaXNOZXciOmZhbHNlLCJfZG9jIjp7Il9pZCI6IjY1NzU2MDNkM2I0ZTRkNjI5YWZjZGE3ZSIsImZpcnN0TmFtZSI6ImtlbmEiLCJsYXN0TmFtZSI6ImZleWlzYSIsInBob25lIjoiKzI1MTk3NDI0NDk5OCIsImVtYWlsIjoia2VuYUBnbWFpbC5jb20iLCJwYXNzd29yZCI6IiQyYSQxMCR0cXF0S24wMHU2U2ZiUE5qeWVYVVllZnRFeEd0bWtuaml4Vm1SQzBiazM3TXBJUjRhRGlLVyIsInJvbGUiOiJNQVNURVIiLCJ2ZXJpZnkiOmZhbHNlLCJkYXRlT2ZCaXJ0aCI6IjIwMjMtMTItMTBUMDA6MDA6MDAuMDAwWiIsInNjaG9vbCI6IkFiZW5lemVyIiwiZ3JhZGUiOiIxMiIsInBvaW50cyI6MCwiY3JlYXRlZEF0IjoiMjAyMy0xMi0xMFQwNjo1Mjo0NS45NDVaIiwiX192IjowfSwiX2lkIjoiNjU3NTYwM2QzYjRlNGQ2MjlhZmNkYTdlIiwiaWF0IjoxNzAzOTUwODMyLCJleHAiOjE3MDQwMzcyMzJ9.50WikDe7WTh-1uO97XubkXSkbRKLrpbzKyRdVH8eooU';

class ProblemRepositoryImpl implements ProblemRepository {
  final ProblemLocalDataSource localDataSource;
  final ProblemRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProblemRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Problem>> getById({required String id}) async {
    if (await networkInfo.isConnected) {
      try {
        final problem = await remoteDataSource.getProblem(id: id, token: token);
        await localDataSource.update([problem]);
        return Right(problem);
      } on ServerException {
        return Left(ServerFailure());
      } on CacheException {
        return Left(CacheFailure());
      }
    } else {
      try {
        final problem = await localDataSource.getProblem(id);
        return Right(problem);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Problem>>> list({
    List<String>? source,
    List<String>? value,
    List<int>? year,
    List<String>? target,
    List<String>? courses,
    List<String>? difficulty,
    List<String>? topic,
    List<String>? grade,
  }) async {
    try {
      final problem = await localDataSource.list(
        source: source,
        value: value,
        year: year,
        target: target,
        courses: courses,
        difficulty: difficulty,
        topic: topic,
        grade: grade,
      );
      return Right(problem);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> delete({required String id}) async {
    try {
      final problem = await localDataSource.delete(id);
      return Right(problem);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Problem>> lastUpdate() async {
    try {
      final problem = await localDataSource.lastUpdated();
      return Right(problem);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Problem>>> syncProblem(
      {required DateTime lastUpdated, int? skip, int? limit}) async {
    if (await networkInfo.isConnected) {
      try {
        final problem = await remoteDataSource.syncProblem(
          lastUpdated: lastUpdated,
          token: token,
          skip: skip,
          limit: limit,
        );
        await localDataSource.update(problem);
        return Right(problem);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
