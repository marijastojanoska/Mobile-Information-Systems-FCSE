import 'package:flutter/material.dart';
import '../models/jokes.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Joke> _favorites = [];

  List<Joke> get favorites => _favorites;

  void toggleFavorite(Joke joke) {
    if (_favorites.contains(joke)) {
      _favorites.remove(joke);
    } else {
      _favorites.add(joke);
    }
    notifyListeners();
  }

  bool isFavorite(Joke joke) {
    return _favorites.contains(joke);
  }
}
