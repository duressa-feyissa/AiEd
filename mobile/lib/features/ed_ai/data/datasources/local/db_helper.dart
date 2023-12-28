import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "edai.db";
  static final DatabaseHelper instance = DatabaseHelper._internal();

  factory DatabaseHelper() => instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    return await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: 1, onCreate: _createTables);
  }

  void _createTables(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS user (
      id TEXT PRIMARY KEY,
      firstName TEXT NOT NULL,
      lastName TEXT NOT NULL,
      username TEXT NOT NULL,
      verify INTEGER NOT NULL DEFAULT 0,
      role TEXT NOT NULL DEFAULT 'User',
      points INTEGER NOT NULL DEFAULT 0,
      phone TEXT NOT NULL,
      image TEXT,
      email TEXT,
      cover TEXT,
      school TEXT,
      grade TEXT,
      dateOfBirth TEXT,
      createAt TEXT,
      updateAt TEXT
    ),
    CREATE TABLE IF NOT EXISTS problem (
      id TEXT PRIMARY KEY,
      source TEXT,
      value TEXT,
      year INTEGER,
      essay TEXT,
      target TEXT,
      courses TEXT,
      difficulty TEXT,
      topic TEXT,
      grade TEXT,
      points INTEGER,
      question TEXT,
      answer TEXT,
      createAt TEXT,
      updateAt TEXT
    ),
  ''');
  }
}
