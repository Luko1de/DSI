import 'package:flutter/material.dart';
import 'homePage.dart'; // Importa a tela de início
import '../components/user_profile.dart';
import '../components/user_info_card.dart';
import '../components/genre_chips.dart';
import '../components/section_title.dart';
import '../components/favorite_movies_carousel.dart';
import '../components/bottom_nav_bar.dart';

class TelaPerfil extends StatefulWidget {
  @override
  _TelaPerfilState createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  int _selectedIndex = 2; // Inicia na página de Perfil

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/filmePage');
        break;
      case 2:
        // Já está na tela de Perfil
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          color: Color(0xFFFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  color: Color(0xFF161616),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 32, bottom: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserProfileImage(
                          imageAssetPath: "assets/x.png",
                        ),
                        UserInfoCard(
                          title: "Maria Joana Lima",
                          subtitle: "joaninha@gmail.com",
                          obscurePassword: "***********",
                          dateOfBirth: "DD/MM/AAAA",
                        ),
                        SectionTitle(title: "Gêneros favoritos"),
                        GenreChips(
                          genres: ["Drama", "Ficção Científica", "Romance"],
                        ),
                        SectionTitle(title: "Favoritos"),
                        FavoriteMoviesCarousel(
                          movieAssetPaths: [
                            "assets/images/movie1.png",
                            "assets/images/movie2.png",
                            "assets/images/movie3.png",
                          ],
                          onMovieTap: (assetPath) {
                            Navigator.pushNamed(context, '/filmePage');
                          },
                        ),
                        SizedBox(height: 64), // Espaçamento no final da lista
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
