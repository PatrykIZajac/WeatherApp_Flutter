import 'package:first_app/models/favorite_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  static Db _instance = Db._internal();
  Database _database;

  static final String tableFavorite = 'Favorite';

  factory Db() {
    return _instance;
  }

  Db._internal() {}

  init() async {
    _database = await openDatabase(
        join(await getDatabasesPath(), 'database.db'),
        version: 1, onCreate: (Database database, int version) async {
      await database.execute(
          'CREATE TABLE $tableFavorite (id INTEGER PRIMARY KEY AUTOINCREMENT, longitude DOUBLE, latitude DOUBLE, name STRING)');
    });
  }

  Database getDatabase() {
    if (_database == null) {
      throw Exception('Call init() first!');
    }
    return _database;
  }

  static Future<FavoriteModel> insertFavorite(
      FavoriteModel favoriteModel) async {
    favoriteModel.id = await Db().getDatabase().insert(
        tableFavorite, favoriteModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.fail);
    return favoriteModel;
  }

  static Future<int> deleteFavorite(FavoriteModel favoriteModel) async {
    return deleteById(favoriteModel.id);
  }

  static Future<List<FavoriteModel>> getFavorites() async {
    return FavoriteModel.fromMap(await Db().getDatabase().query(tableFavorite));
  }

  static Future<int> deleteById(int id) async {
    return await Db()
        .getDatabase()
        .delete(tableFavorite, where: 'id=?', whereArgs: [id]);
  }
}
