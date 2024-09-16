import 'package:flutter/material.dart';
import 'Cinemas.dart';
import 'homePage.dart'; // Importa a tela de início
import '../components/movie_image.dart';
import '../components/movie_title.dart';
import '../components/movie_details.dart';
import '../components/section_title.dart';
import '../components/genre_chips.dart';
import '../components/movie_cast.dart';
import '../components/movie_synopsis.dart';
import '../components/lateral_nav_bar.dart'; // Importa o componente de menu lateral
import 'myMovies.dart';
import 'reviewsPage.dart';
import 'catalogPage.dart';
import 'profilePage.dart';
import 'favoritePage.dart';
import 'mapPage.dart';

class TelaFilme extends StatefulWidget {
  const TelaFilme({super.key});

  @override
  _TelaFilmeState createState() => _TelaFilmeState();
}

class _TelaFilmeState extends State<TelaFilme> {
  int _selectedIndex = 1; // Inicia na página de Filmes

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CatalogPage()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfilePage()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FavoritePage()));
        break;
      case 4:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MapPage()));
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const MeusFilmesPage()), // Adicione a nova tela
        );
        break;
      case 6:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Cinemas()),
        );
        break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToReviews() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ReviewsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Filme'),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ],
      ),
      drawer: LateralNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          _onItemTapped(index);
          Navigator.pop(context); // Fecha o drawer ao selecionar um item
        },
      ),
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
                          cast: [
                            "Timothée Chalamet",
                            "Zendaya",
                            "Rebecca Ferguson",
                            "Javier Bardem",
                            "Josh Brolin",
                            "Austin Butler",
                            "Florence Pugh",
                            "Dave Bautista",
                            "Christopher Walken"
                          ],
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
    );
  }
}
