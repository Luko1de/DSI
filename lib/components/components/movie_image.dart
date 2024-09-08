import 'package:flutter/material.dart';

class MovieImage extends StatelessWidget {
  final String imagePath;

  const MovieImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double imageHeight =
        size.width * 0.5; // Ajuste a altura conforme necessário

    return Container(
      width: size.width, // Largura igual à largura da tela
      height: imageHeight, // Altura ajustada
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://image.tmdb.org/t/p/w500$imagePath'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
