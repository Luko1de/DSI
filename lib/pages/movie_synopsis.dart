import 'package:flutter/material.dart';

class MovieSynopsis extends StatelessWidget {
  final String synopsis;

  const MovieSynopsis({super.key, required this.synopsis});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 36, vertical: 31),
      child: Text(
        synopsis,
        style: const TextStyle(
          color: Color(0xFFFAFAFA),
          fontSize: 12,
        ),
      ),
    );
  }
}
