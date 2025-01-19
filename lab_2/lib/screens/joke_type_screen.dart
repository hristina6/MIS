import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../services/api_services.dart';

class JokeTypeScreen extends StatelessWidget {
  final String type;

  JokeTypeScreen({Key? key, required this.type}) : super(key: key);

  final ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jokes from type: $type'),
      ),
      body: FutureBuilder<List<Joke>>(
        future: apiServices.fetchJokesByType(type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final jokes = snapshot.data!;
            return ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(jokes[index].setup),
                  subtitle: Text(jokes[index].punchline),
                );
              },
            );
          }
        },
      ),
    );
  }
}
