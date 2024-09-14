import 'package:flutter/material.dart';

class MovieDetailPage extends StatelessWidget {
  final Map<String, dynamic> movieData;

  const MovieDetailPage({super.key, required this.movieData});

  @override
  Widget build(BuildContext context) {
    final movieTitle = movieData['title'] ?? 'Título Desconhecido';
    final movieOverview = movieData['overview'] ?? 'Sem descrição';
    final moviePosterUrl = movieData['poster_path'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(movieTitle),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (moviePosterUrl.isNotEmpty)
              Image.network(
                'https://image.tmdb.org/t/p/w500$moviePosterUrl',
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.white,
                      size: 50,
                    ),
                  );
                },
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                movieTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                movieOverview,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
