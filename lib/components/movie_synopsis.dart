import 'package:flutter/material.dart';

class MovieSynopsis extends StatelessWidget {
  final String synopsis;

  MovieSynopsis({required this.synopsis});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 36, vertical: 31),
      child: Text(
        synopsis,
        style: TextStyle(
          color: Color(0xFFFAFAFA),
          fontSize: 12,
        ),
      ),
    );
  }
}
