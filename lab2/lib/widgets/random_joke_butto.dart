import 'package:flutter/material.dart';

class RandomJokeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RandomJokeButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.casino),
      tooltip: 'Random Joke',
      onPressed: onPressed,
    );
  }
}
