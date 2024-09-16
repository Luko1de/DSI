import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testes/pages/commentsPage.dart';
import 'Cinemas.dart';
import 'HomePage.dart';
import 'ReviewsPage.dart';
import 'HomePage.dart';
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
import 'myMovies.dart';

class MoviePage extends StatefulWidget {
  final String movieId;

  const MoviePage({super.key, required this.movieId});

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  int _currentIndex = 1;
  late Future<DocumentSnapshot> _movieData;
  final User? _currentUser = FirebaseAuth.instance.currentUser;

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

  void _showEditReviewDialog(
      String reviewId, Map<String, dynamic> currentReview) {
    final TextEditingController _ratingController =
        TextEditingController(text: currentReview['rating']?.toString() ?? '');
    final TextEditingController _commentController =
        TextEditingController(text: currentReview['comment'] ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Comentário'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _ratingController,
                decoration: const InputDecoration(labelText: 'Nota'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _commentController,
                decoration: const InputDecoration(labelText: 'Comentário'),
                keyboardType: TextInputType.text,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('movies')
                    .doc(widget.movieId)
                    .collection('reviews')
                    .doc(reviewId)
                    .update({
                  'rating': _ratingController.text,
                  'comment': _commentController.text,
                });
                Navigator.of(context).pop();
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalhes do Filme',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            color: Colors.white,
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
            final posterPath = movie['poster_path'] ?? '';
            final posterUrl = 'https://image.tmdb.org/t/p/w500$posterPath';

            final genresString = movie['genres'] ?? '';
            final genresList = genresString.split('-');

            final castString = movie['credits'] ?? '';
            final castList = castString.split('-');

            return Container(
              color: const Color.fromARGB(255, 240, 3, 3),
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
                            const SizedBox(
                              height: 10,
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
                            const SectionTitle(title: "Avaliações"),
                            StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('movies')
                                  .doc(widget.movieId)
                                  .collection('reviews')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text(
                                          'Erro ao carregar comentários: ${snapshot.error}'));
                                }

                                if (!snapshot.hasData ||
                                    snapshot.data!.docs.isEmpty) {
                                  return const Center(
                                      child: Text(
                                          'Nenhum comentário disponível.'));
                                }

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...snapshot.data!.docs.map((doc) {
                                      final review =
                                          doc.data() as Map<String, dynamic>;
                                      return GestureDetector(
                                        onTap: () {
                                          _showEditReviewDialog(doc.id, review);
                                        },
                                        child: Dismissible(
                                          key: Key(doc.id),
                                          direction:
                                              DismissDirection.endToStart,
                                          onDismissed: (direction) async {
                                            await FirebaseFirestore.instance
                                                .collection('movies')
                                                .doc(widget.movieId)
                                                .collection('reviews')
                                                .doc(doc.id)
                                                .delete();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Comentário excluído')),
                                            );
                                          },
                                          background: Container(
                                            color: Colors.red,
                                            child: const Align(
                                              alignment: Alignment.centerRight,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Card(
                                              color: const Color.fromARGB(
                                                  255, 20, 20, 20),
                                              child: ListTile(
                                                leading: const Icon(
                                                  Icons.person,
                                                  size: 40,
                                                  color: Colors.red,
                                                ),
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      review['email'] ??
                                                          'Email não disponível',
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      'Nota: ${review['rating'] ?? 'N/A'}',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      review['comment'] ??
                                                          'Comentário não disponível',
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    const SizedBox(height: 20),
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AllReviewsPage(
                                                      movieId: widget.movieId),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.red, // Cor do botão
                                          iconColor:
                                              Colors.white, // Cor do ícone
                                          textStyle: const TextStyle(
                                              fontSize: 16), // Tamanho do texto
                                        ),
                                        child: const Text(
                                          'Ver mais',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
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
