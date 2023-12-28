import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile/core/network/info.dart';
import 'package:mobile/features/ed_ai/data/datasources/local/db_helper.dart';
import 'package:mobile/features/ed_ai/data/datasources/local/problem.dart';
import 'package:mobile/features/ed_ai/data/datasources/remote/problem.dart';
import 'package:mobile/features/ed_ai/data/repositories/problem.dart';
import 'package:mobile/features/ed_ai/domains/repositories/problem.dart';
import 'package:mobile/features/ed_ai/domains/use_cases/problem/getById.dart';
import 'package:mobile/features/ed_ai/domains/use_cases/problem/list.dart';
import 'package:mobile/features/ed_ai/presentations/bloc/problem/problem_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features
  // - Problem
  sl.registerFactory(() => ProblemBloc(
        listProblem: sl(),
        problemGetById: sl(),
      ));

  // Use cases
  // - Problem
  sl.registerLazySingleton(() => ProblemGetById(sl()));
  sl.registerLazySingleton(() => ListProblem(sl()));

  // Repository
  // - Problem
  sl.registerLazySingleton<ProblemRepository>(
    () => ProblemRepositoryImpl(
        remoteDataSource: sl(), networkInfo: sl(), localDataSource: sl()),
  );

  // Data sources - Remote
  // - Problem
  sl.registerLazySingleton<ProblemRemoteDataSource>(
      () => ProblemRemoteDataSourceImpl(client: sl()));

  // Data sources - Local
  // - Problem
  sl.registerLazySingleton<ProblemLocalDataSource>(
      () => ProblemLocalDataSourceImpl(database: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

// Initialize and register the DatabaseHelper as a lazy singleton
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
}
