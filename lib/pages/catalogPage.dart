import 'package:flutter/material.dart';
import 'package:testes/components/bottom_nav_bar.dart';
import 'HomePage.dart';
import 'MapPage.dart';
import 'ProfilePage.dart';
import 'FavoritePage.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});
  
  
  @override
  _CatalogPageState createState() => _CatalogPageState();
}


class _CatalogPageState extends State<CatalogPage> {
  int _currentIndex = 1; // Índice da barra de navegação inferior

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navegação
    if (index == 0) {
      // Navegue para a tela inicial
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 1) {
      // Navegue para a tela de filmes
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CatalogPage()),
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Catálogo de Filmes',
            style: TextStyle(fontSize: 16, color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implementar a funcionalidade de busca
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Implementar a funcionalidade de filtro
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 20, // Substituir pela lista real de filmes
        itemBuilder: (context, index) {
          return MovieCard(
            title: 'Filme $index',
            poster: 'assets/images/poster$index.jpg',
          );
        },
      ),

      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),

    );
  }
}

class MovieCard extends StatelessWidget {
  final String title;
  final String poster;

  const MovieCard({super.key, required this.title, required this.poster});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(poster),
          Text(title),
        ],
      ),
    );
  }
}
