import 'package:flutter/material.dart';

class JokeCard extends StatelessWidget {
  final String jokeType;
  final VoidCallback onTap;
  final VoidCallback onFavorite;
  final bool isFavorite;

  const JokeCard({
    Key? key,
    required this.jokeType,
    required this.onTap,
    required this.onFavorite,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(jokeType),
        trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : null,
          ),
          onPressed: onFavorite,
        ),
        onTap: onTap,
      ),
    );
  }
}
