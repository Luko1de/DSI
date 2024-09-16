import 'package:flutter/material.dart';
import 'package:testes/pages/myMovies.dart';
import 'Cinemas.dart';
import 'HomePage.dart';
import 'CatalogPage.dart';
import 'FavoritePage.dart';
import 'MapPage.dart';
import '../components/user_profile.dart';
import '../components/user_info_card.dart';
// import '../components/genre_chips.dart'; // Comentado para evitar erros
import '../components/section_title.dart';
import '../components/favorite_movies_carousel.dart';
import '../components/lateral_nav_bar.dart';
import 'myMovies.dart';

class ProfilePage extends StatefulWidget {
  final String? username;
  final String? email;
  final String? dateOfBirth;
  // final List<String>? favoriteGenres; // Comentado para evitar erros

  const ProfilePage({
    super.key,
    this.username,
    this.email,
    this.dateOfBirth,
    // this.favoriteGenres, // Comentado para evitar erros
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 2;

  void _onItemTapped(int index) async {
    // Fecha o drawer antes de iniciar a navegação
    Navigator.pop(context);

    setState(() {
      _currentIndex = index;
    });

    // Navegação com pushReplacement para substituir a página atual
    switch (index) {
      case 0:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
        break;
      case 1:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CatalogPage()));
        break;
      case 2:
        // Não faz nada pois já está na página de Perfil
        break;
      case 3:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const FavoritePage()));
        break;
      case 4:
        Navigator.pushReplacement(
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
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Perfil',
            style: TextStyle(
              color: Colors.white, // Define a cor do texto como branco
              fontSize: 24, // Ajuste o tamanho da fonte conforme necessário
            ), // Define a cor do texto como branco
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 250, 245, 245)),
      ),
      drawer: LateralNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _onItemTapped(index);
        },
      ),
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
    );
  }
}
