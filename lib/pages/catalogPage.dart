import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testes/pages/myMovies.dart';
import 'ProfilePage.dart';
import 'FavoritePage.dart';
import 'HomePage.dart';
import 'MapPage.dart';
import 'MoviePage.dart';
import 'myMovies.dart';

class CatalogPage extends StatefulWidget {
  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
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
    'Ficção Científica'
  ];

  @override
  void initState() {
    super.initState();
    _moviesStream =
        FirebaseFirestore.instance.collection('movies').limit(20).snapshots();
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
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  _updateSelectedGenre(genre);
                  Navigator.pop(context); // Fecha o BottomSheet
                },
              );
            }).toList(),
          ),
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
        title: const Text('Catalog', style: TextStyle(color: Colors.white)),
        centerTitle: true,
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
                      hintStyle: TextStyle(color: Colors.white54),
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    onChanged: _updateSearchQuery,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.filter_list, color: Colors.red),
                  onPressed:
                      _showGenreSelection, // Chama o BottomSheet ao clicar no ícone
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _moviesStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: const Text(
                      'Nenhum filme encontrado.',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  );
                }

                final movies = snapshot.data!.docs
                    .where((doc) {
                      final movie = doc.data() as Map<String, dynamic>;
                      final title = movie['title']?.toLowerCase() ?? '';
                      final genreString = movie['genres'] as String;
                      final genres = genreString
                          .split('-')
                          .map((g) => g.trim().toLowerCase())
                          .toList();

                      final matchesSearchQuery = title.contains(_searchQuery);
                      final matchesGenre = _selectedGenre == 'Todos' ||
                          genres.contains(_selectedGenre.toLowerCase());

                      return matchesSearchQuery && matchesGenre;
                    })
                    .take(20)
                    .toList();

                if (movies.isEmpty) {
                  return Center(
                    child: const Text(
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
                    final movieTitle = movie['title'] ?? 'Título Desconhecido';
                    final moviePosterUrl = movie['poster_path'] ?? '';

                    return MovieCard(
                      title: movieTitle,
                      poster: moviePosterUrl,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MoviePage(
                              movieId: movieId,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              color: Colors.red,
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: Icon(Icons.home, color: Colors.black),
                    title:
                        Text('Início', style: TextStyle(color: Colors.black)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.movie, color: Colors.black),
                    title:
                        Text('Filmes', style: TextStyle(color: Colors.black)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CatalogPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.black),
                    title:
                        Text('Perfil', style: TextStyle(color: Colors.black)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.favorite, color: Colors.black),
                    title: Text('Favoritos',
                        style: TextStyle(color: Colors.black)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FavoritePage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.map, color: Colors.black),
                    title: Text('Mapas', style: TextStyle(color: Colors.black)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.star,
                        color: Colors.black), // Ícone para Meus Filmes
                    title: Text('Meus Filmes',
                        style: TextStyle(color: Colors.black)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MeusFilmesPage()), // Navegação para MyMoviesPage
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final String title;
  final String poster;
  final VoidCallback onTap;

  const MovieCard({
    Key? key,
    required this.title,
    required this.poster,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.grey[900],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: poster.isNotEmpty
                    ? Image.network(
                        'https://image.tmdb.org/t/p/w500$poster',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.white,
                              size: 50,
                            ),
                          );
                        },
                      )
                    : Image.asset(
                        'assets/images/default_poster.jpg',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
