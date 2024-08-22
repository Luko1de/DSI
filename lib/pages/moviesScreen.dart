import 'package:flutter/material.dart';
import 'homePage.dart'; // Importa a tela de início
import '../components/movie_image.dart';
import '../components/movie_title.dart';
import '../components/movie_details.dart';
import '../components/section_title.dart';
import '../components/genre_chips.dart';
import '../components/movie_cast.dart';
import '../components/movie_synopsis.dart';
import '../components/bottom_nav_bar.dart';
import 'reviewsPage.dart';

class TelaFilme extends StatefulWidget {
  @override
  _TelaFilmeState createState() => _TelaFilmeState();
}

class _TelaFilmeState extends State<TelaFilme> {
  int _selectedIndex = 1; // Inicia na página de Filmes

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        // Já está na tela de Filmes
        break;
      case 2:
        // Navegar para a tela de Perfil (a ser implementada)
        break;
      case 3:
        // Navegar para a tela de Sair (a ser implementada)
        break;
      default:
        break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToReviews() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaAvaliacoes()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xFFFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  color: Color(0xFF161616),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: _navigateToReviews,
                          child: MovieImage(imagePath: "dune.webp"),
                        ),

                        MovieTitle(title: "Dune: Part Two"),
                        MovieDetails(
                          duration: "167 min",
                          year: "2024",
                          rating: "8.3",
                        ),
                        SectionTitle(title: "Sinopse"),
                        MovieSynopsis(
                          synopsis:
                              "Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.",
                        ),
                        SectionTitle(title: "Gênero"),
                        GenreChips(genres: ["Aventura", "Ficção Científica"]),
                        SectionTitle(title: "Elenco"),
                        MovieCast(
                          cast:
                              "Timothée Chalamet\nZendaya\nRebecca Ferguson\nJavier Bardem\nJosh Brolin\nAustin Butler\nFlorence Pugh\nDave Bautista\nChristopher Walken",
                        ),
                        SizedBox(height: 64), // Add some spacing at the bottom
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
