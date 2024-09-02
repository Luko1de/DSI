import 'package:flutter/material.dart';
import 'HomePage.dart'; // Importa a tela de início
import 'ReviewsPage.dart';
import 'CatalogPage.dart';
import 'ProfilePage.dart';
import 'FavoritePage.dart';
import 'MapPage.dart';
import '../components/movie_image.dart';
import '../components/movie_title.dart';
import '../components/movie_details.dart';
import '../components/section_title.dart';
import '../components/genre_chips.dart';
import '../components/movie_cast.dart';
import '../components/movie_synopsis.dart';
import '../components/bottom_nav_bar.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  void _navigateToReviews() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ReviewsPage()),
    );
  }

  int _currentIndex = 1; // Índice da barra de navegação inferior

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Adicione a lógica de navegação para cada item aqui
    if (index == 0) {
      // Navegue para a tela inicial
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 1) {
      // Navegue para a tela de catálogo
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CatalogScreen()),
      );
    } else if (index == 2) {
      // Navegue para a tela de perfil
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    } else if (index == 3) {
      // Navegue para a tela de favoritos
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FavoritePage()),
      );
    } else if (index == 4) {
      // Navegue para a tela de mapas
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MapPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFFFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  color: const Color(0xFF161616),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: _navigateToReviews,
                          child: const MovieImage(imagePath: "dune.webp"),
                        ),

                        const MovieTitle(title: "Dune: Part Two"),
                        const MovieDetails(
                          duration: "167 min",
                          year: "2024",
                          rating: "8.3",
                        ),
                        const SectionTitle(title: "Sinopse"),
                        const MovieSynopsis(
                          synopsis:
                              "Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.",
                        ),
                        const SectionTitle(title: "Gênero"),
                        const GenreChips(
                            genres: ["Aventura", "Ficção Científica"]),
                        const SectionTitle(title: "Elenco"),
                        const MovieCast(
                          cast:
                              "Timothée Chalamet\nZendaya\nRebecca Ferguson\nJavier Bardem\nJosh Brolin\nAustin Butler\nFlorence Pugh\nDave Bautista\nChristopher Walken",
                        ),
                        const SizedBox(
                            height: 64), // Add some spacing at the bottom
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegue para a página de reviews ao clicar no botão
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ReviewsPage()),
          );
        },
        backgroundColor: Colors.red, // Cor de fundo do botão
        child: const Icon(
          Icons.add, // Ícone do botão
          color: Colors.white, // Cor do ícone
        ),
      ),
    );
  }
}
