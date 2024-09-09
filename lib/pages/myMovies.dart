import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testes/pages/addedMovie.dart';
import '../components/lateral_nav_bar.dart';
import 'cadastroMovie.dart';
import 'MoviePage.dart';
import 'HomePage.dart';
import 'CatalogPage.dart';
import 'ProfilePage.dart';
import 'FavoritePage.dart';
import 'MapPage.dart';

class MeusFilmesPage extends StatefulWidget {
  const MeusFilmesPage({super.key});

  @override
  _MeusFilmesPageState createState() => _MeusFilmesPageState();
}

class _MeusFilmesPageState extends State<MeusFilmesPage> {
  late Stream<QuerySnapshot> _moviesStream;
  String _searchQuery = '';
  String _selectedGenre = 'Todos';
  final List<String> _genres = [
    'Todos',
    'Ação',
    'Comédia',
    'Drama',
    'Terror',
    'Romance',
    'Ficção Científica',
  ];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _moviesStream = FirebaseFirestore.instance
        .collection('filmes')
        .where('cadastradoPeloUsuario', isEqualTo: true)
        .snapshots();
  }

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  void _updateSelectedGenre(String genre) {
    setState(() {
      _selectedGenre = genre;
    });
  }

  void _showGenreSelection() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.grey[900],
          child: ListView(
            children: _genres.map((genre) {
              return ListTile(
                title: Text(
                  genre,
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () {
                  _updateSelectedGenre(genre);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
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

  void _editMovie(String movieId, Map<String, dynamic> movieData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaDeCadastroDeFilme(
          movieId: movieId,
          existingData: movieData,
        ),
      ),
    );
  }

  void _deleteMovie(String movieId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir Filme'),
          content: const Text('Tem certeza de que deseja excluir este filme?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('filmes')
                    .doc(movieId)
                    .delete();
                Navigator.pop(context);
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Meus Filmes', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      drawer: LateralNavBar(
        currentIndex: currentIndex,
        onTap: _onItemTapped,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar filmes...',
                      hintStyle: const TextStyle(color: Colors.white54),
                      prefixIcon: const Icon(Icons.search, color: Colors.white),
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    onChanged: _updateSearchQuery,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list, color: Colors.red),
                  onPressed: _showGenreSelection,
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _moviesStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhum filme cadastrado.',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  );
                }

                final movies = snapshot.data!.docs.where((doc) {
                  final movie = doc.data() as Map<String, dynamic>;
                  final title = movie['nome']?.toString().toLowerCase() ?? '';
                  final genreString = movie['genero']?.toString() ?? '';
                  final genres = genreString
                      .split('-')
                      .map((g) => g.trim().toLowerCase())
                      .toList();

                  final matchesSearchQuery = title.contains(_searchQuery);
                  final matchesGenre = _selectedGenre == 'Todos' ||
                      genres.contains(_selectedGenre.toLowerCase());

                  return matchesSearchQuery && matchesGenre;
                }).toList();

                if (movies.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhum filme encontrado.',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index].data() as Map<String, dynamic>;
                    final movieId = movies[index].id;
                    final movieTitle = movie['nome'] ?? 'Título Desconhecido';
                    final moviePosterUrl = movie['imagem'] ?? '';

                    return MovieCard(
                      title: movieTitle,
                      poster: moviePosterUrl,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddedMoviePage(
                              movieId: movieId,
                            ),
                          ),
                        );
                      },
                      onEdit: () => _editMovie(movieId, movie),
                      onDelete: () => _deleteMovie(movieId),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TelaDeCadastroDeFilme(),
            ),
          );
        },
        backgroundColor: const Color(0xFFEF233C),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final String title;
  final String poster;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const MovieCard({
    Key? key,
    required this.title,
    required this.poster,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8.0)),
                child: poster.isNotEmpty
                    ? Image.network(
                        poster,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image,
                                size: 50, color: Colors.white),
                      )
                    : const Icon(Icons.broken_image,
                        size: 50, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
