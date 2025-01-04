import 'dart:convert';
import '../models/jokes.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://official-joke-api.appspot.com';

  static Future<List<String>> getJokeTypes() async {
    final response = await http.get(Uri.parse('$baseUrl/types'));
    if (response.statusCode == 200) {
      return List<String>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load joke types');
    }
  }

  static Future<List<Joke>> getJokesByType(String type) async {
    final response = await http.get(Uri.parse('$baseUrl/jokes/$type/ten'));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((data) => Joke.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load jokes');
    }
  }

  static Future<Joke> getRandomJoke() async {
    final response = await http.get(Uri.parse('$baseUrl/random_joke'));
    if (response.statusCode == 200) {
      return Joke.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load random joke');
    }
  }
}
