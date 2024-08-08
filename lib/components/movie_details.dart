import 'package:flutter/material.dart';

class MovieDetails extends StatelessWidget {
  final String duration;
  final String year;
  final String rating;

  MovieDetails(
      {required this.duration, required this.year, required this.rating});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 27, horizontal: 100),
        child: Row(
          children: [
            buildImage("https://i.imgur.com/1tMFzp8.png",
                width: 18, height: 18, margin: EdgeInsets.only(right: 4)),
            Text(
              duration,
              style: TextStyle(
                color: Color(0xFFFAFAFA),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Text(
              year,
              style: TextStyle(
                color: Color(0xFFFAFAFA),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            buildImage("https://i.imgur.com/1tMFzp8.png",
                width: 16, height: 16, margin: EdgeInsets.only(right: 4)),
            Text(
              rating,
              style: TextStyle(
                color: Color(0xFFFAFAFA),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String url,
      {double width = 32, double height = 32, EdgeInsets? margin}) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      child: Image.network(url, fit: BoxFit.fill),
    );
  }
}
