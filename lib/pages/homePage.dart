import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:testes/components/bottom_nav_bar.dart';
import 'FavoritePage.dart';
import 'catalogPage.dart';
import 'MoviePage.dart';
import 'ProfilePage.dart';
import 'MapPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Índice da barra de navegação inferior

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Adicione a lógica de navegação para cada item aqui
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CatalogScreen()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FavoritePage()),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MapPage()),
      );
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
          actions: const []),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGenreSection(
              context,
              'Acho que você pode gostar',
              3,
              screenHeight,
              screenWidth,
            ),
            _buildGenreSection(
              context,
              'Drama',
              10,
              screenHeight,
              screenWidth,
            ),
            _buildGenreSection(
              context,
              'Ficção Científica',
              10,
              screenHeight,
              screenWidth,
            ),
            _buildGenreSection(
              context,
              'Animação',
              10,
              screenHeight,
              screenWidth,
            ),
            _buildGenreSection(
              context,
              'Comédia',
              10,
              screenHeight,
              screenWidth,
            ),
            _buildGenreSection(
              context,
              'Documentário',
              10,
              screenHeight,
              screenWidth,
            ),
            _buildGenreSection(
              context,
              'Infantil',
              10,
              screenHeight,
              screenWidth,
            ),
            _buildGenreSection(
              context,
              'Musical',
              10,
              screenHeight,
              screenWidth,
            ),
            _buildGenreSection(
              context,
              'Romance',
              10,
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

  Widget _buildGenreSection(BuildContext context, String genre, int itemCount,
      double screenHeight, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(screenWidth * 0.02, screenHeight * 0.02,
              screenWidth * 0.02, screenHeight * 0.01),
          child: Text(
            genre,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        CarouselSlider.builder(
          itemCount: itemCount,
          options: CarouselOptions(
            height: screenHeight * 0.35,
            viewportFraction: 0.7, // Ajuste para o tamanho do Pixel 7
            enlargeCenterPage: true,
          ),
          itemBuilder: (BuildContext context, int index, int pageViewIndex) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MoviePage(),
                  ),
                );
              },
              child: Container(
                height: screenHeight * 0.35,
                width: screenWidth * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), // Borda arredondada
                  border: Border.all(color: Colors.white), // Borda branca
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/poster_0${index % 3 + 1}.png',
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
  }
}
