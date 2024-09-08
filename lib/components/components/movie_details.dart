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
        margin: const EdgeInsets.symmetric(vertical: 27, horizontal: 20),
        child: Row(
          children: [
            buildIcon(Icons.access_time, // Duração
                margin: const EdgeInsets.only(right: 8)),
            Text(
              duration,
              style: const TextStyle(
                color: Color(0xFFFAFAFA),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            buildIcon(Icons.calendar_today, // Ano
                margin: const EdgeInsets.only(right: 8)),
            Text(
              year,
              style: const TextStyle(
                color: Color(0xFFFAFAFA),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            buildIcon(Icons.star, // Nota
                margin: const EdgeInsets.only(right: 4)),
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

  Widget buildIcon(IconData iconData, {EdgeInsets? margin}) {
    return Container(
      margin: margin,
      child: Icon(
        iconData,
        color: const Color(0xFFFAFAFA),
        size: 18,
      ),
    );
  }
}
