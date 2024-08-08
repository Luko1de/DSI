import 'package:flutter/material.dart';

class MovieCast extends StatelessWidget {
  final String cast;

  MovieCast({required this.cast});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 121,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cast,
                  style: TextStyle(
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
                margin: EdgeInsets.only(top: 23),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(54),
                  color: Color(0xFFF5001E),
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
