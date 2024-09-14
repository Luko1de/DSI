import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'HomePage.dart';
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
import '../components/lateral_nav_bar.dart';

class AddedMoviePage extends StatefulWidget {
  final String movieId;

  const AddedMoviePage({super.key, required this.movieId});

  @override
  _AddedMoviePageState createState() => _AddedMoviePageState();
}

class _AddedMoviePageState extends State<AddedMoviePage> {
  int _currentIndex = 1;
  late Future<DocumentSnapshot> _movieData;

  @override
  void initState() {
    super.initState();
    _movieData = FirebaseFirestore.instance
        .collection('filmes')
        .doc(widget.movieId)
        .get();
  }

  void _navigateToReviews() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewsPage(),
        settings: RouteSettings(arguments: widget.movieId),
      ),
    );
  }

  void _onItemTapped(int index) {
    Navigator.pop(context); // Fechar o Drawer após a navegação
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
          MaterialPageRoute(builder: (context) => MapPage()),
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
        title: const Text(
          'Detalhes do Filme',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: LateralNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot>(
          future: _movieData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text('Filme não encontrado.'));
            }

            final movie = snapshot.data!.data() as Map<String, dynamic>;

            final posterPath = movie['imagem'] ?? '';
            final posterUrl = posterPath.isNotEmpty
                ? posterPath
                : 'https://image.tmdb.org/t/p/w500/default_poster.png';

            // Corrigindo a conversão dos gêneros
            final genresData = movie['genero'] ?? [];
            final genresList = genresData is List
                ? genresData.map((e) => e.toString()).toList()
                : <String>[];

            // Corrigindo a conversão do elenco
            final castData = movie['elenco'] ?? '';
            final castList = castData is String
                ? castData.split(',').map((e) => e.trim()).toList()
                : <String>[];

            return Container(
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
                              child: Container(
                                alignment: Alignment.center,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    posterUrl,
                                    height: 400,
                                    width: 300,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/default_poster.png',
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            MovieTitle(
                              title: movie['nome'] ?? 'Título do Filme',
                            ),
                            MovieDetails(
                              duration: movie['duracao']?.toString() ??
                                  'Duração não disponível',
                              year: movie['release_date']?.substring(0, 4) ??
                                  'Ano não disponível',
                              rating: movie['vote_average']?.toString() ??
                                  'Nota não disponível',
                            ),
                            const SectionTitle(title: "Sinopse"),
                            MovieSynopsis(
                              synopsis:
                                  movie['sinopse'] ?? 'Sinopse não disponível.',
                            ),
                            const SectionTitle(title: "Gênero"),
                            GenreChips(
                              genres: genresList,
                            ),
                            const SectionTitle(title: "Elenco"),
                            MovieCast(
                              cast: castList,
                            ),
                            const SizedBox(
                              height: 64,
                              width: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToReviews,
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
