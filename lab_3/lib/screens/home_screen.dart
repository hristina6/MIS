import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../widgets/joke_card.dart';
import 'joke_type_screen.dart';
import 'favorite_jokes_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiServices apiServices = ApiServices();
  final Set<String> favoriteJokes = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Type of jokes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteJokesScreen(favorites: favoriteJokes.toList()),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.casino),
            onPressed: () {
              Navigator.pushNamed(context, '/random-joke');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: apiServices.fetchJokeTypes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final jokeTypes = snapshot.data!;
            return ListView.builder(
              itemCount: jokeTypes.length,
              itemBuilder: (context, index) {
                return JokeCard(
                  jokeType: jokeTypes[index],
                  isFavorite: favoriteJokes.contains(jokeTypes[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JokeTypeScreen(type: jokeTypes[index]),
                      ),
                    );
                  },
                  onFavorite: () {
                    setState(() {
                      if (favoriteJokes.contains(jokeTypes[index])) {
                        favoriteJokes.remove(jokeTypes[index]);
                      } else {
                        favoriteJokes.add(jokeTypes[index]);
                      }
                    });
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
