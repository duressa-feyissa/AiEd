import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:mobile/core/errors/exception.dart';
import 'package:mobile/features/ed_ai/data/models/problem.dart';

const baseUrl = 'https://aied.onrender.com/api/v1';

abstract class ProblemRemoteDataSource {
  Future<List<ProblemModel>> getProblems({
    required String token,
    String? source,
    String? value,
    int? year,
    String? target,
    String? courses,
    String? difficulty,
    String? topic,
    String? grade,
    String? unit,
  });

  Future<ProblemModel> getProblem({
    required String id,
    required String token,
  });

  Future<List<ProblemModel>> syncProblem({
    required DateTime lastUpdated,
    required String token,
    int? skip,
    int? limit,
  });
}

class ProblemRemoteDataSourceImpl implements ProblemRemoteDataSource {
  const ProblemRemoteDataSourceImpl({
    required this.client,
  });

  final Client client;

  @override
  Future<ProblemModel> getProblem({
    required String id,
    required String token,
  }) async {
    final response = await client.get(
      Uri.parse('$baseUrl/problems/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      return ProblemModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProblemModel>> getProblems({
    required String token,
    String? source,
    String? value,
    int? year,
    String? target,
    String? courses,
    String? difficulty,
    String? topic,
    String? grade,
    String? unit,
  }) async {
    final response = await client.get(
      Uri.parse('$baseUrl/problems'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final problems = json.decode(response.body) as List;
      return problems.map((e) => ProblemModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProblemModel>> syncProblem({
    required DateTime lastUpdated,
    required String token,
    int? skip = 0,
    int? limit = 100,
  }) async {
    print(lastUpdated);
    final response = await client.get(
      Uri.parse(
          '$baseUrl/problems/sync?skip=$skip&limit=$limit&last=$lastUpdated'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final problems = json.decode(response.body) as List;
      return problems.map((e) => ProblemModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
