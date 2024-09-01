import 'package:flutter/material.dart';

class FavoriteMoviesCarousel extends StatelessWidget {
  final List<String> movieAssetPaths;
  final Function(String) onMovieTap;

  const FavoriteMoviesCarousel({super.key, 
    required this.movieAssetPaths,
    required this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movieAssetPaths.length,
        itemBuilder: (context, index) {
          return _buildMovieTile(movieAssetPaths[index]);
        },
      ),
    );
  }

  Widget _buildMovieTile(String assetPath) {
    return GestureDetector(
      onTap: () {
        onMovieTap(assetPath);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: 120,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            "dune.webp",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
