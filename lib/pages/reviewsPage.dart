import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'HomePage.dart';
import 'ProfilePage.dart';
import 'FavoritePage.dart';
import 'MapPage.dart';
import 'CatalogPage.dart';
import '../components/lateral_nav_bar.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  int _currentIndex = 0; // Índice atual da página
  String? _selectedOption;
  bool _isFavorite = false;
  bool _isWatched = false;
  final Color _inactiveColor = Colors.white.withOpacity(0.5);
  final Color _activeFavoriteColor = Colors.red;
  final Color _activeWatchedColor = Colors.green;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

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
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ProfilePage()));
        break;
      case 3:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const FavoritePage()));
        break;
      case 4:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MapPage()));
        break;
    }
  }

  Future<void> _addToFavorites(
      String movieId, String title, String posterPath) async {
    if (movieId.isEmpty || title.isEmpty || posterPath.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Informações do filme inválidas.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    DocumentReference favoriteRef = _firestore
        .collection('users')
        .doc(_currentUser?.uid)
        .collection('favorites')
        .doc(movieId);

    try {
      await favoriteRef.set({
        'title': title,
        'poster_path': posterPath,
        'timestamp': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Filme adicionado aos favoritos.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao adicionar aos favoritos: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _saveReview(
      String movieId, String title, String posterPath) async {
    if (movieId.isEmpty || title.isEmpty || posterPath.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Informações do filme inválidas.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final review = {
      'rating': _selectedOption,
      'isFavorite': _isFavorite,
      'isWatched': _isWatched,
      'comment': _commentController.text,
    };

    try {
      await _firestore
          .collection('users')
          .doc(_currentUser?.uid)
          .collection('reviews')
          .doc(movieId)
          .set(review);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Avaliação salva com sucesso.'),
          backgroundColor: Colors.green,
        ),
      );

      if (_isFavorite) {
        await _addToFavorites(movieId, title, posterPath);
      }

      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar a avaliação: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context)?.settings.arguments as String? ?? '';
    final movieTitle = 'Título do Filme'; // Ajuste para o título correto
    final moviePosterUrl =
        '/path/to/poster'; // Ajuste para o caminho do poster correto

    if (movieId.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: const Text(
            'ID do filme não encontrado.',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Avaliar o filme',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButton<String>(
                isExpanded: true,
                value: _selectedOption,
                items: List.generate(10, (index) => (index + 1).toString())
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedOption = newValue;
                  });
                },
                hint: const Text(
                  'Escolha uma opção',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                dropdownColor: Colors.black,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                underline: const SizedBox(),
                iconEnabledColor: Colors.red,
              ),
            ),
            const SizedBox(height: 16),
            _buildToggleRow(
                'Favorito', Icons.favorite, _isFavorite, _activeFavoriteColor,
                () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
            }),
            const SizedBox(height: 8),
            _buildToggleRow('Assistido', Icons.check_circle, _isWatched,
                _activeWatchedColor, () {
              setState(() {
                _isWatched = !_isWatched;
              });
            }),
            const SizedBox(height: 16),
            const Text(
              'Comentário',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Escreva seu comentário aqui',
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.black12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _saveReview(movieId, movieTitle, moviePosterUrl);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .red, // Fix the named parameter to 'backgroundColor'
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text(
                  'Salvar Avaliação',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: LateralNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildToggleRow(String label, IconData icon, bool value,
      Color activeColor, VoidCallback onPressed) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            icon,
            color: value ? activeColor : _inactiveColor,
            size: 30,
          ),
          onPressed: onPressed,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            color: value ? activeColor : _inactiveColor,
          ),
        ),
      ],
    );
  }
}
