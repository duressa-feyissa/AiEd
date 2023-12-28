import 'package:mobile/core/errors/exception.dart';
import 'package:mobile/features/ed_ai/data/datasources/local/db_helper.dart';
import 'package:mobile/features/ed_ai/data/models/problem.dart';
import 'package:sqflite/sqflite.dart';

abstract class ProblemLocalDataSource {
  Future<List<ProblemModel>> update(List<ProblemModel> problems);
  Future<void> delete(String id);
  Future<ProblemModel> getProblem(String id);
  Future<List<ProblemModel>> list({
    String? source,
    String? value,
    int? year,
    String? target,
    String? courses,
    String? difficulty,
    String? topic,
    String? grade,
  });
}

class ProblemLocalDataSourceImpl implements ProblemLocalDataSource {
  const ProblemLocalDataSourceImpl({
    required this.database,
  });

  final DatabaseHelper database;

  @override
  Future<void> delete(String id) async {
    final db = await database.database;
    final result = await db.delete('problem', where: 'id = ?', whereArgs: [id]);
    if (result == 0) {
      throw CacheException();
    }
  }

  @override
  Future<ProblemModel> getProblem(String id) async {
    final db = await database.database;
    final result = await db.query('problem', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return ProblemModel.fromJson(result.first);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<ProblemModel>> update(List<ProblemModel> problems) async {
    final db = await database.database;
    final batch = db.batch();

    for (final problem in problems) {
      batch.insert(
        'problem',
        problem.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    final result = await batch.commit();

    if (result.isEmpty) {
      throw CacheException();
    } else {
      return problems;
    }
  }

  @override
  Future<List<ProblemModel>> list({
    String? source,
    String? value,
    int? year,
    String? target,
    String? courses,
    String? difficulty,
    String? topic,
    String? grade,
  }) async {
    final db = await database.database;
    final sql = StringBuffer('SELECT * FROM problem WHERE 1 = 1');
    final args = <dynamic>[];

    if (source != null) {
      sql.write(' AND source = ?');
      args.add(source);
    }

    if (value != null) {
      sql.write(' AND value = ?');
      args.add(value);
    }

    if (year != null) {
      sql.write(' AND year = ?');
      args.add(year);
    }

    if (target != null) {
      sql.write(' AND target = ?');
      args.add(target);
    }

    if (courses != null) {
      sql.write(' AND courses = ?');
      args.add(courses);
    }

    if (difficulty != null) {
      sql.write(' AND difficulty = ?');
      args.add(difficulty);
    }

    if (topic != null) {
      sql.write(' AND topic = ?');
      args.add(topic);
    }

    if (grade != null) {
      sql.write(' AND grade = ?');
      args.add(grade);
    }

    final result = await db.rawQuery(sql.toString(), args);

    if (result.isNotEmpty) {
      return result.map((e) => ProblemModel.fromDbJson(e)).toList();
    } else {
      print(result);
      throw CacheException();
    }
  }
}
