import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'HomePage.dart';
import 'ReviewsPage.dart';
import 'CatalogPage.dart';
import 'ProfilePage.dart';
import 'FavoritePage.dart';
import 'MapPage.dart';
import '../components/movie_title.dart';
import '../components/movie_details.dart';
import '../components/section_title.dart';
import '../components/movie_cast.dart';
import '../components/movie_synopsis.dart';
import '../components/bottom_nav_bar.dart';

class MoviePage extends StatefulWidget {
  final String movieId;

  const MoviePage({super.key, required this.movieId});

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  int _currentIndex = 1;
  late Future<DocumentSnapshot> _movieData;

  @override
  void initState() {
    super.initState();
    _movieData = FirebaseFirestore.instance
        .collection('movies')
        .doc(widget.movieId)
        .get();
  }

  void _navigateToReviews() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ReviewsPage(),
        settings: RouteSettings(arguments: widget.movieId),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  const HomePage()),
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
          MaterialPageRoute(builder: (context) =>  const ProfilePage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  const FavoritePage()),
        );
        break;
      case 4:
        Navigator.push(
          context, MaterialPageRoute(builder: (context) =>  MapPage()));
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

            // Use o poster_path diretamente, assumindo que é uma URL parcial
            final posterPath = movie['poster_path'] ?? '';
            final posterUrl = 'https://image.tmdb.org/t/p/w500$posterPath';

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
                                    height: 400,
                                    width: 300,
                                    alignment: Alignment.center,
                                    posterUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                          'assets/default_poster.png',
                                          fit: BoxFit.cover);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            MovieTitle(
                                title: movie['title'] ?? 'Título do Filme'),
                            MovieDetails(
                              duration:
                                  movie['runtime'] ?? 'Duração não disponível',
                              year: movie['release_date']?.substring(0, 4) ??
                                  'Ano não disponível',
                              rating: movie['vote_average']?.toString() ??
                                  'Nota não disponível',
                            ),
                            const SectionTitle(title: "Sinopse"),
                            MovieSynopsis(
                              synopsis: movie['overview'] ??
                                  'Sinopse não disponível.',
                            ),
                            const SectionTitle(title: "Gênero"),
                            //GenreChips(
                            //genres: List<String>.from(movie['genres'] ?? []),
                            //),
                            const SectionTitle(title: "Elenco"),
                            MovieCast(
                              cast: List<String>.from(
                                  movie['cast'] ?? ['Elenco não disponível.']),
                            ),
                            const SizedBox(height: 64),
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
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
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
