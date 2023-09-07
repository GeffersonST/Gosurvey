import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._();

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'survey_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE survey_results(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question1 TEXT,
        question2 TEXT,
        question3 INTEGER
      )
    ''');
  }

  Future<int> insertSurveyResult(Map<String, dynamic> row) async {
    final Database db = await instance.database;
    return await db.insert('survey_results', row);
  }

  Future<List<Map<String, dynamic>>> getSurveyResults() async {
    final Database db = await instance.database;
    return await db.query('survey_results');
  }
}
