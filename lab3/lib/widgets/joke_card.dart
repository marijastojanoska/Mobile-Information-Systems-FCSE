import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/jokes.dart';
import '../services/favorites_provider.dart';

class JokeCard extends StatelessWidget {
  final Joke joke;

  const JokeCard({super.key, required this.joke});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(joke.setup, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 8),
                  Text(
                    joke.punchline,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                favoritesProvider.isFavorite(joke) ? Icons.favorite : Icons.favorite_border,
                color: favoritesProvider.isFavorite(joke) ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                favoritesProvider.toggleFavorite(joke);
              },
            ),
          ],
        ),
      ),
    );
  }
}
