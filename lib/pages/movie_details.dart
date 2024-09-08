import 'package:flutter/material.dart';

class MovieDetails extends StatelessWidget {
  final String duration;
  final String year;
  final String rating;

  const MovieDetails(
      {super.key,
      required this.duration,
      required this.year,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 27, horizontal: 340),
        child: Row(
          children: [
            buildImage("https://i.imgur.com/1tMFzp8.png",
                width: 18, height: 18, margin: const EdgeInsets.only(right: 4)),
            Text(
              duration,
              style: const TextStyle(
                color: Color(0xFFFAFAFA),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text(
              year,
              style: const TextStyle(
                color: Color(0xFFFAFAFA),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            buildImage("https://i.imgur.com/1tMFzp8.png",
                width: 16, height: 16, margin: const EdgeInsets.only(right: 4)),
            Text(
              rating,
              style: const TextStyle(
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
