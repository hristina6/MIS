import 'package:flutter/material.dart';
import '../models/jokes.dart';
import '../services/api_services.dart';

class RandomJokeScreen extends StatelessWidget {
  final ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joke type of the day'),
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
            return Center(
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
