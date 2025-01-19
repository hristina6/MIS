import 'package:flutter/material.dart';

class FavoriteJokesScreen extends StatelessWidget {
  final List<String> favorites;

  const FavoriteJokesScreen({Key? key, required this.favorites}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Jokes'),
      ),
      body: favorites.isEmpty
          ? const Center(child: Text('No favorite jokes yet.'))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(favorites[index]),
            ),
          );
        },
      ),
    );
  }
}
