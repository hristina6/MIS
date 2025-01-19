import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/jokes.dart';

class JokeTypeScreen extends StatelessWidget {
  final String type;
  final ApiServices apiServices = ApiServices();

  JokeTypeScreen({required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joke type: $type'),
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
