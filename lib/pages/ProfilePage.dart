import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'CatalogPage.dart';
import 'FavoritePage.dart';
import 'MapPage.dart';
import '../components/user_profile.dart';
import '../components/user_info_card.dart';
// import '../components/genre_chips.dart'; // Comentado para evitar erros
import '../components/section_title.dart';
import '../components/favorite_movies_carousel.dart';
import '../components/bottom_nav_bar.dart';

class ProfilePage extends StatefulWidget {
  final String? username;
  final String? email;
  final String? dateOfBirth;
  // final List<String>? favoriteGenres; // Comentado para evitar erros

  const ProfilePage({
    Key? key,
    this.username,
    this.email,
    this.dateOfBirth,
    // this.favoriteGenres, // Comentado para evitar erros
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CatalogPage()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            username: widget.username,
            email: widget.email,
            dateOfBirth: widget.dateOfBirth,
            // favoriteGenres: widget.favoriteGenres, // Comentado para evitar erros
          ),
        ),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FavoritePage()),
      );
    } else if (index == 4) {
      Navigator.pushReplacement(
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
                          imageAssetPath: "assets/profilepic.png",
                        ),
                        UserInfoCard(
                          title: widget.username ?? "Nome não fornecido",
                          subtitle: widget.email ?? "Email não fornecido",
                          obscurePassword: "***********",
                          dateOfBirth:
                              widget.dateOfBirth ?? "Data não fornecida",
                        ),
                        const SectionTitle(title: "Gêneros favoritos"),
                        // GenreChips(
                        //   genres: widget.favoriteGenres ?? ["Nenhum gênero selecionado"],
                        // ), // Comentado para evitar erros
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
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
