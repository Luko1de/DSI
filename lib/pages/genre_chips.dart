import 'package:flutter/material.dart';

class GenreChips extends StatelessWidget {
  final List<String> genres;

  GenreChips({required this.genres});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 36, vertical: 26),
        child: Row(
          children: genres
              .map((genre) => Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Chip(
                      label: Text(
                        genre,
                        style: TextStyle(color: Color(0xFFFAFAFA)),
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