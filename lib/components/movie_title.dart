import 'package:flutter/material.dart';

class MovieTitle extends StatelessWidget {
  final String title;

  MovieTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 104),
      child: Text(
        title,
        style: TextStyle(
          color: Color(0xFFFAFAFA),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
