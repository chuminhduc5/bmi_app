import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/bmi_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bmi_history.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bmi_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        weight REAL,
        height REAL,
        bmi REAL,
        evaluate TEXT
      )
    ''');
  }

  // Thêm BMI vào database
  Future<int> insertBMI(BMIModel bmi) async {
    final db = await database;
    return await db.insert('bmi_history', bmi.toMap());
  }

  // Lấy danh sách BMI từ database
  Future<List<BMIModel>> getAllBMI() async {
    final db = await database;
    final result = await db.query('bmi_history', orderBy: 'id DESC');
    return result.map((json) => BMIModel.fromMap(json)).toList();
  }

  // Xóa tất cả dữ liệu BMI
  Future<int> deleteAllBMI() async {
    final db = await database;
    return await db.delete('bmi_history');
  }
}
