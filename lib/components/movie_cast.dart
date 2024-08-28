import 'package:flutter/material.dart';

class MovieCast extends StatelessWidget {
  final String cast;

  const MovieCast({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 121,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cast,
                  style: const TextStyle(
                    color: Color(0xFFFAFAFA),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 23),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(54),
                  color: const Color(0xFFF5001E),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Image.network(
                    "https://i.imgur.com/1tMFzp8.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
