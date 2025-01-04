import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/favorites_provider.dart';
import '../widgets/joke_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoritesProvider>(context).favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: favorites.isEmpty
          ? Center(
        child: Text(
          'No favorite jokes yet!',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      )
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return JokeCard(joke: favorites[index]);
        },
      ),
    );
  }
}
