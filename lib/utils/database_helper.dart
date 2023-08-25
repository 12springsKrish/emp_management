import 'package:emp_management_app/models/emp_details.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  late Database _database;

  Future openDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    _database = await sql.openDatabase(
      path.join(dbPath, "employee.db"),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE employees (
            id INTEGER PRIMARY KEY,
            name TEXT,
            role TEXT,
            startDate TEXT,
            endDate TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  Future<void> insertEmployee(String name, String role,String startDate, String endDate) async {
    await _database.insert(
      'employees',
      {'name': name, 'role': role,'startDate' : startDate, 'endDate' : endDate},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateEmployee(Employee employee) async {
    await _database.update(
      'employees',
      {
        'name': employee.name,
        'role': employee.role,
        'startDate': employee.startDate,
        'endDate' : employee.endDate
      },
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  Future<List<Employee>> getEmployees() async {
    if (_database == null) {
      await openDatabase();
    }

    final List<Map<String, dynamic>> employeeMaps = await _database.query('employees');

    return List.generate(employeeMaps.length, (index) {
      return Employee(
        id: employeeMaps[index]['id'],
        name: employeeMaps[index]['name'],
        role: employeeMaps[index]['role'],
        startDate: employeeMaps[index]['startDate'],
          endDate: employeeMaps[index]['endDate']

      );
    });
  }

  Future<void> deleteEmployee(int id) async {
    await _database.delete(
      'employees',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> printEmployees() async {
    final employees = await _database.query('employees');
    print('Employees in the database:');
    for (var employee in employees) {
      print('ID: ${employee['id']}, Name: ${employee['name']}, Role: ${employee['role']}, Date${employee['startDate']}');
    }
  }
}
