import 'package:mobile/core/errors/exception.dart';
import 'package:mobile/features/ed_ai/data/datasources/local/db_helper.dart';
import 'package:mobile/features/ed_ai/data/models/user.dart';

abstract class UserLocalDataSource {
  Future<UserModel> update(UserModel user);
  Future<void> delete(String id);
  Future<UserModel> getUser(String id);
  Future<UserModel> save(UserModel user);
  Future<UserModel> me();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  const UserLocalDataSourceImpl({
    required this.database,
  });

  final DatabaseHelper database;

  @override
  Future<void> delete(String id) async {
    final db = await database.database;
    final result = await db.delete('user', where: 'id = ?', whereArgs: [id]);
    if (result == 0) {
      throw CacheException();
    }
  }

  @override
  Future<UserModel> getUser(String id) async {
    final db = await database.database;
    final result = await db.query('user', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return UserModel.fromJson(result.first);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<UserModel> save(UserModel user) async {
    final db = await database.database;
    final result = await db.insert('user', user.toJson());
    if (result == 0) {
      throw CacheException();
    } else {
      return user;
    }
  }

  @override
  Future<UserModel> update(UserModel user) async {
    final db = await database.database;
    final result = await db
        .update('user', user.toJson(), where: 'id = ?', whereArgs: [user.id]);
    if (result == 0) {
      throw CacheException();
    } else {
      return user;
    }
  }

  @override
  Future<UserModel> me() async {
    final db = await database.database;
    final result = await db.query('user');
    if (result.isNotEmpty) {
      return UserModel.fromJson(result.first);
    } else {
      throw CacheException();
    }
  }
}
