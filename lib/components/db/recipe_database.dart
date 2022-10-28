//import path
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/recipe_db_model.dart';

//https://www.youtube.com/watch?v=UpKrhZ0Hppk

class RecipeDatabase {
  static final RecipeDatabase instance = RecipeDatabase._init();

  static Database? _database;

  RecipeDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('recipeDb.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final intType = 'INTEGER NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
    CREATE TABLE $tableRecipe (
      ${RecipeFields.id} $idType,
      ${RecipeFields.title} $textType,
      ${RecipeFields.image} $textType

    )
    ''');
  }

  Future<RecipeDb> create(RecipeDb recipeDb) async {
    final db = await instance.database;

    // final json = recipe.toJson();
    // final columns = '${RecipeFields.title}, ${RecipeFields.image}, ${RecipeFields.servings}, ${RecipeFields.readyInMinutes}, ${RecipeFields.summary}, ${RecipeFields.isFavorite}';
    // final values = '${json[RecipeFields.title]}, ${json[RecipeFields.image]}, ${json[RecipeFields.servings]}, ${json[RecipeFields.readyInMinutes]}, ${json[RecipeFields.summary]}, ${json[RecipeFields.isFavorite]}';

    final id = await db.insert(
      tableRecipe,
      recipeDb.toJson(),
    );
    return recipeDb.copy(id: id);
  }

  Future<RecipeDb> readRecipe(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableRecipe,
      columns: RecipeFields.values,
      where: '${RecipeFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return RecipeDb.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<RecipeDb>> readAllRecipes() async {
    final db = await instance.database;

    final orderBy = '${RecipeFields.title} ASC';
    final result = await db.query(tableRecipe, orderBy: orderBy);

    return result.map((json) => RecipeDb.fromJson(json)).toList();
  }

  Future<int> update(RecipeDb recipeDb) async {
    final db = await instance.database;

    return db.update(
      tableRecipe,
      recipeDb.toJson(),
      where: '${RecipeFields.id} = ?',
      whereArgs: [recipeDb.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableRecipe,
      where: '${RecipeFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    final db = await instance.database;

    return await db.delete(
      tableRecipe,
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
