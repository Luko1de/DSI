import 'package:flutter/material.dart';

class GenreChips extends StatelessWidget {
  final List<String> genres;

  const GenreChips({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 36, vertical: 26),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: genres
              .map((genre) => Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Chip(
                      label: Text(
                        genre,
                        style: const TextStyle(color: Color(0xFFFAFAFA)),
                      ),
                      backgroundColor: Colors.grey[800],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
