import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/movie_detail_page.dart';
import 'HomePage.dart';
import 'CatalogPage.dart';
import 'ProfilePage.dart';
import 'MapPage.dart';
import 'ReviewsPage.dart';
import '../components/bottom_nav_bar.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  int _currentIndex = 3;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  Future<List<Map<String, dynamic>>> _fetchFavorites() async {
    if (_currentUser == null) {
      print('Nenhum usuário logado.');
      return [];
    }

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(_currentUser!.uid)
          .collection('favorites')
          .get();

      if (snapshot.docs.isEmpty) {
        print('Nenhum favorito encontrado para o usuário.');
        return [];
      } else {
        print('Favoritos encontrados: ${snapshot.docs.length}');
        return snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      }
    } catch (e) {
      print('Erro ao buscar favoritos: $e');
      return [];
    }
  }

  void _onFavoriteTapped(Map<String, dynamic> movieData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailPage(movieData: movieData),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CatalogPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
      case 3:
        // Já está na FavoritePage
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MapPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Favoritos'),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print('Erro ao carregar favoritos: ${snapshot.error}');
            return const Center(
              child: Text(
                'Erro ao carregar favoritos.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum filme favorito encontrado.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final favoriteMovies = snapshot.data!;

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            padding: const EdgeInsets.all(16.0),
            itemCount: favoriteMovies.length,
            itemBuilder: (context, index) {
              final movie = favoriteMovies[index];
              final posterPath = movie['poster_path'] ?? '';
              final posterUrl = 'https://image.tmdb.org/t/p/w500$posterPath';
              final title = movie['title'] ?? 'Título desconhecido';

              return GestureDetector(
                onTap: () => _onFavoriteTapped(movie),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    posterUrl,
                    fit: BoxFit.cover,
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
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
