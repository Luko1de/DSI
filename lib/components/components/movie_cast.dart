import 'package:flutter/material.dart';

class MovieCast extends StatelessWidget {
  final List<String> cast;

  const MovieCast({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: cast
          .map((actor) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  actor,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ))
          .toList(),
    );
  }
}
