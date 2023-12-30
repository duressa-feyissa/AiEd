import 'package:mobile/core/errors/exception.dart';
import 'package:mobile/features/ed_ai/data/datasources/local/db_helper.dart';
import 'package:mobile/features/ed_ai/data/models/problem.dart';
import 'package:sqflite/sqflite.dart';

abstract class ProblemLocalDataSource {
  Future<List<ProblemModel>> update(List<ProblemModel> problems);
  Future<String> delete(String id);
  Future<ProblemModel> getProblem(String id);

  Future<List<ProblemModel>> list({
    List<String>? source,
    List<String>? value,
    List<int>? year,
    List<String>? target,
    List<String>? courses,
    List<String>? difficulty,
    List<String>? topic,
    List<String>? grade,
  });
  Future<ProblemModel> lastUpdated();
}

class ProblemLocalDataSourceImpl implements ProblemLocalDataSource {
  const ProblemLocalDataSourceImpl({
    required this.database,
  });

  final DatabaseHelper database;

  @override
  Future<String> delete(String id) async {
    final db = await database.database;
    final result = await db.delete('problem', where: 'id = ?', whereArgs: [id]);
    if (result == 0) {
      throw CacheException();
    }
    return id;
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

    try {
      await db.transaction((txn) async {
        final batch = txn.batch();
        for (var problem in problems) {
          batch.insert(
            'problem',
            problem.toDbJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
        await batch.commit();
      });
    } catch (e) {
      throw CacheException();
    }

    return problems;
  }

  @override
  Future<List<ProblemModel>> list({
    List<String>? source,
    List<String>? value,
    List<int>? year,
    List<String>? target,
    List<String>? courses,
    List<String>? difficulty,
    List<String>? topic,
    List<String>? grade,
  }) async {
    final db = await database.database;
    final sql = StringBuffer('SELECT * FROM problem WHERE 1 = 1');
    final args = <dynamic>[];

    void addCondition(
        String columnName, List<String>? values, String condition) {
      if (values != null && values.isNotEmpty) {
        sql.write(
            ' $condition $columnName IN (${List.filled(values.length, '?').join(', ')})');
        args.addAll(values.map((value) => value.toLowerCase()));
      }
    }

    addCondition('source', source, 'OR');
    addCondition('value', value, 'OR');
    addCondition('year', year?.map((e) => e.toString()).toList(), 'OR');
    addCondition('target', target, 'AND');
    addCondition('courses', courses, 'AND');
    addCondition('difficulty', difficulty, 'AND');
    addCondition('topic', topic, 'AND');
    addCondition('grade', grade, 'AND');

    final result = await db.rawQuery(sql.toString(), args);

    if (result.isNotEmpty) {
      return result.map((e) => ProblemModel.fromDbJson(e)).toList();
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ProblemModel> lastUpdated() async {
    final db = await database.database;
    final result =
        await db.query('problem', orderBy: 'updatedAt DESC', limit: 1);
    if (result.isNotEmpty) {
      return ProblemModel.fromDbJson(result.first);
    } else {
      throw CacheException();
    }
  }
}
