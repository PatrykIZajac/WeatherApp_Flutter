import 'package:first_app/database/db.dart';
import 'package:first_app/models/favorite_model.dart';
import 'package:flutter/foundation.dart';

class FavoriteProvider extends ChangeNotifier {
  List<FavoriteModel> _favorites = [];
  List<FavoriteModel> get favorites => _favorites;

  FavoriteProvider() {
    _initFavorites();
  }

  Future<void> _initFavorites() async {
    _favorites.addAll(await Db.getFavorites());
    notifyListeners();
  }

  Future<FavoriteModel> addToFavorite(FavoriteModel favoriteModel) async {
    FavoriteModel insertedModel = await Db.insertFavorite(favoriteModel);
    _favorites.add(insertedModel);
    notifyListeners();
  }

  Future<void> deleteFromFavorite(FavoriteModel favoriteModel) async {
    _favorites.remove(favoriteModel);
    await Db.deleteFavorite(favoriteModel);
    notifyListeners();
  }

  Future<void> deleteById(int id) async {
    _favorites.removeWhere((element) => element.id == id);
  }
}
