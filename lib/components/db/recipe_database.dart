//import path
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/recipe_model.dart';

//https://www.youtube.com/watch?v=UpKrhZ0Hppk

class RecipeDatabase {
  static final RecipeDatabase instance = RecipeDatabase._init();

  static Database? _database;

  RecipeDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('recipe.db');
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
      ${RecipeFields.image} $textType,
      ${RecipeFields.servings} $intType,
      ${RecipeFields.readyInMinutes} $intType,
      ${RecipeFields.summary} $textType,
      ${RecipeFields.isFavorite} $boolType
     
  
      
    
    )
    ''');
  }
  //${RecipeFields.extendedIngredients} $textType
  //${RecipeFields.steps} $textType
  //${RecipeFields.ingredientDone} $boolType

  Future<Recipe> create(Recipe recipe) async {
    final db = await instance.database;

    // final json = recipe.toJson();
    // final columns = '${RecipeFields.title}, ${RecipeFields.image}, ${RecipeFields.servings}, ${RecipeFields.readyInMinutes}, ${RecipeFields.summary}, ${RecipeFields.isFavorite}';
    // final values = '${json[RecipeFields.title]}, ${json[RecipeFields.image]}, ${json[RecipeFields.servings]}, ${json[RecipeFields.readyInMinutes]}, ${json[RecipeFields.summary]}, ${json[RecipeFields.isFavorite]}';

    final id = await db.insert(tableRecipe, recipe.toJson());
    return recipe.copy(id: id);
  }

  Future<Recipe> readRecipe(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableRecipe,
      columns: RecipeFields.values,
      where: '${RecipeFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Recipe.fromJsonDb(maps.first); //fromjsonDb????
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Recipe>> readAllRecipes() async {
    final db = await instance.database;

    final orderBy = '${RecipeFields.title} ASC';
    final result = await db.query(tableRecipe, orderBy: orderBy);

    return result
        .map((json) => Recipe.fromJsonDb(json))
        .toList(); //fromjsonDb????
  }

  Future<int> update(Recipe recipe) async {
    final db = await instance.database;

    return db.update(
      tableRecipe,
      recipe.toJson(),
      where: '${RecipeFields.id} = ?',
      whereArgs: [recipe.id],
    );
  }

  //delete
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableRecipe,
      where: '${RecipeFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
