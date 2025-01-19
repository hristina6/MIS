import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../services/api_services.dart';

class RandomJokeScreen extends StatelessWidget {
  final ApiServices apiServices = ApiServices();

  RandomJokeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random joke of the day'),
      ),
      body: FutureBuilder<Joke>(
        future: apiServices.fetchRandomJoke(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final joke = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(joke.setup, style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  Text(joke.punchline, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
