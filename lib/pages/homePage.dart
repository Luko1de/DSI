import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'FavoritePage.dart';
import 'CatalogPage.dart';
import 'MoviePage.dart';
import 'ProfilePage.dart';
import 'MapPage.dart';
import '../components/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Índice da barra de navegação inferior
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FavoritePage()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MapPage()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double screenHeight = size.height;
    final double screenWidth = size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 32, 31, 31),
        title: const Text('MovieBox'),
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        centerTitle: true,
        actions: const [],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGenreSection(
              context,
              'Acho que você pode gostar',
              'all',
              screenHeight,
              screenWidth,
            ),
            _buildGenreSection(
              context,
              'Drama',
              'Drama',
              screenHeight,
              screenWidth,
            ),
            _buildGenreSection(
              context,
              'Ficção Científica',
              'Science Fiction',
              screenHeight,
              screenWidth,
            ),
            _buildGenreSection(
              context,
              'Animação',
              'Animation',
              screenHeight,
              screenWidth,
            ),
            _buildGenreSection(
              context,
              'Comédia',
              'Comedy',
              screenHeight,
              screenWidth,
            ),
            _buildGenreSection(
              context,
              'Documentário',
              'Documentary',
              screenHeight,
              screenWidth,
            ),
            _buildGenreSection(
              context,
              'Infantil',
              'Children',
              screenHeight,
              screenWidth,
            ),
            _buildGenreSection(
              context,
              'Musical',
              'Musical',
              screenHeight,
              screenWidth,
            ),
            _buildGenreSection(
              context,
              'Romance',
              'Romance',
              screenHeight,
              screenWidth,
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildGenreSection(BuildContext context, String genre, String genreId,
      double screenHeight, double screenWidth) {
    return FutureBuilder<QuerySnapshot>(
      future: _firestore
          .collection('movies')
          .where('genres', isGreaterThanOrEqualTo: genreId)
          .where('genres',
              isLessThanOrEqualTo: genreId + '\uf8ff') // Filtro por string
          .limit(10)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
              child: Text('Nenhum filme encontrado.',
                  style: TextStyle(color: Colors.white)));
        }
        final movies = snapshot.data!.docs;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(screenWidth * 0.02,
                  screenHeight * 0.02, screenWidth * 0.02, screenHeight * 0.01),
              child: Text(
                genre,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            CarouselSlider.builder(
              itemCount: movies.length,
              options: CarouselOptions(
                height: screenHeight * 0.3,
                viewportFraction: 0.7,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
              ),
              itemBuilder:
                  (BuildContext context, int index, int pageViewIndex) {
                final movie = movies[index];
                final posterPath = movie['poster_path'];
                final movieId = movie.id; // Obtém o ID do filme
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoviePage(
                          movieId:
                              movieId, // Passe o ID do filme para MoviePage
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500$posterPath', // Adiciona URL base do TMDB
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/default_poster.png',
                              fit: BoxFit.cover);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: screenHeight * 0.05),
          ],
        );
      },
    );
  }
}
