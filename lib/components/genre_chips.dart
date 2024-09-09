import 'package:flutter/material.dart';

class GenreChips extends StatelessWidget {
  final List<String> genres;

  const GenreChips({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 26),
      child: Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: genres
              .map((genre) => Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Chip(
                      label: Text(
                        genre,
                        style: const TextStyle(color: Color(0xFFFAFAFA), fontFamily: 'Popins', fontWeight: FontWeight.w600),
                      ),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.red)
                      ),
                    ),
                  ))
              .toList(),
        ),
      );
  }
}
