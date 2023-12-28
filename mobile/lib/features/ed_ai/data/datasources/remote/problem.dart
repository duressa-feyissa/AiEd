import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:mobile/core/errors/exception.dart';
import 'package:mobile/features/ed_ai/data/models/problem.dart';

const baseUrl = 'http://localhost:3001/api/v1/problems';

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
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final problems = json.decode(response.body) as List;
      return problems.map((e) => ProblemModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
