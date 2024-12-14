import 'package:flutter/material.dart';
import '../models/jokes.dart';
import '../services/api_services.dart';
import '../widgets/joke_card.dart';

class JokesListScreen extends StatefulWidget {
  final String jokeType;

  const JokesListScreen({required this.jokeType, super.key});

  @override
  _JokesListScreenState createState() => _JokesListScreenState();
}

class _JokesListScreenState extends State<JokesListScreen> {
  late Future<List<Joke>> jokesFuture;

  @override
  void initState() {
    super.initState();
    jokesFuture = ApiService.getJokesByType(widget.jokeType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.jokeType.capitalize()} Jokes'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Joke>>(
        future: jokesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Failed to load jokes. Please try again later.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          } else if (snapshot.hasData) {
            final jokes = snapshot.data!;
            return ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                return JokeCard(joke: jokes[index]);
              },
            );
          } else {
            return Center(
              child: Text(
                'No jokes found.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }
        },
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';
}
