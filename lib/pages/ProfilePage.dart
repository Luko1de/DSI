import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'CatalogPage.dart';
import 'FavoritePage.dart';
import 'MapPage.dart';
import '../components/user_profile.dart';
import '../components/user_info_card.dart';
import '../components/genre_chips.dart';
import '../components/section_title.dart';
import '../components/favorite_movies_carousel.dart';
import '../components/bottom_nav_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 2; // Índice da barra de navegação inferior

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
          constraints: const BoxConstraints.expand(),
          color: const Color(0xFFFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  color: const Color(0xFF161616),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 32, bottom: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const UserProfileImage(
                          imageAssetPath: "assets/x.png",
                        ),
                        const UserInfoCard(
                          title: "Maria Joana Lima",
                          subtitle: "joaninha@gmail.com",
                          obscurePassword: "***********",
                          dateOfBirth: "DD/MM/AAAA",
                        ),
                        const SectionTitle(title: "Gêneros favoritos"),
                        const GenreChips(
                          genres: ["Drama", "Ficção Científica", "Romance"],
                        ),
                        const SectionTitle(title: "Favoritos"),
                        FavoriteMoviesCarousel(
                          movieAssetPaths: const [
                            "assets/images/movie1.png",
                            "assets/images/movie2.png",
                            "assets/images/movie3.png",
                          ],
                          onMovieTap: (assetPath) {
                            Navigator.pushNamed(context, '/filmePage');
                          },
                        ),
                        const SizedBox(
                            height: 64), // Espaçamento no final da lista
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Barra de navegação inferior
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
