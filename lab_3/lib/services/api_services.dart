import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/jokes.dart';

class ApiServices {
  static const String baseUrl = 'https://official-joke-api.appspot.com';

  Future<List<String>> fetchJokeTypes() async {
    final response = await http.get(Uri.parse('$baseUrl/types'));
    if (response.statusCode == 200) {
      return List<String>.from(jsonDecode(response.body));
    } else {
      throw Exception('The type of the joke does not exists');
    }
  }


  Future<List<Joke>> fetchJokesByType(String type) async {
    final response = await http.get(Uri.parse('$baseUrl/jokes/$type/ten'));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((data) => Joke.fromJson(data))
          .toList();
    } else {
      throw Exception('Error loading the jokes');
    }
  }

  Future<Joke> fetchRandomJoke() async {
    final response = await http.get(Uri.parse('$baseUrl/random_joke'));
    if (response.statusCode == 200) {
      return Joke.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error loading the random joke');
    }
  }
}
