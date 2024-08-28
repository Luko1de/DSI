// lib/pages/tela_favoritos.dart
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../components/custom_search_bar.dart';
import '../components/bottom_nav_bar.dart';

import 'HomePage.dart';
import 'CatalogPage.dart';
import 'ProfilePage.dart';
import 'MapPage.dart';

class FavoritePage extends StatefulWidget {
  
  const FavoritePage({super.key});
  @override
  _FavoritePageState createState() => _FavoritePageState();

}

class _FavoritePageState extends State<FavoritePage> { 
  
  int _currentIndex = 3; // Índice da barra de navegação inferior

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
    // Exemplo de lista de filmes favoritos
    final List<String> favoritos = [
      'assets/dune.webp',
      'assets/dune.webp',
      'assets/dune.webp',
      'assets/dune.webp',
      'assets/dune.webp',
      'assets/dune.webp',
      'assets/dune.webp',
      'assets/dune.webp',
      'assets/dune.webp',
    ];

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFFFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  color: const Color(0xFF161616),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 38, bottom: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 12, left: 37),
                          child: const Text(
                            "Favoritos",
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CustomSearchBar(
                          onSearch: (query) {
                            print("Busca realizada por: $query");
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 10.0), // Espaço nas laterais e vertical
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, // 3 filmes por fileira
                              crossAxisSpacing:
                                  15, // Espaçamento horizontal entre os filmes
                              mainAxisSpacing:
                                  15, // Espaçamento vertical entre os filmes
                              childAspectRatio: 2 /
                                  3, // Proporção de aspecto para as imagens dos filmes
                            ),
                            itemCount: favoritos.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // Lógica para navegar para a tela de detalhes do filme
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      12.0), // Bordas arredondadas
                                  child: Image.asset(
                                    favoritos[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    
    //barra de navegação
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),

  );
  }
}