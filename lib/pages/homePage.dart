import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'catalogPage.dart';
import 'moviesScreen.dart';
import 'profileScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Índice da barra de navegação inferior

  @override
  Widget build(BuildContext context) {
    // Obtém as dimensões da tela
    final size = MediaQuery.of(context).size;
    final double screenHeight = size.height;
    final double screenWidth = size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 32, 31, 31),
        title: const Text('MovieBox'),
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título de recomendação
            Padding(
              padding: EdgeInsets.fromLTRB(screenWidth * 0.02,
                  screenHeight * 0.02, screenWidth * 0.02, screenHeight * 0.01),
              child: const Text(
                'Acho que você pode gostar',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            // Slider de filmes recomendados
            CarouselSlider.builder(
              itemCount: 3,
              options: CarouselOptions(
                height: screenHeight * 0.35,
                viewportFraction: 0.7, // Ajuste para o tamanho do Pixel 7
                enlargeCenterPage: true,
              ),
              itemBuilder:
                  (BuildContext context, int index, int pageViewIndex) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaFilme(),
                      ),
                    );
                  },
                  child: Container(
                    height: screenHeight * 0.35,
                    width: screenWidth * 0.6,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(16), // Borda arredondada
                      border: Border.all(color: Colors.white), // Borda branca
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/poster_0${index % 3 + 1}.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/default_poster.png',
                              fit: BoxFit.cover);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: screenHeight * 0.05),
            // Gênero Drama
            _buildGenreSection(context, 'Drama', 10, screenHeight, screenWidth),
            // Gênero Ficção Científica
            _buildGenreSection(
                context, 'Ficção Científica', 10, screenHeight, screenWidth),
            // Gênero Animação
            _buildGenreSection(
                context, 'Animação', 10, screenHeight, screenWidth),
            // Gênero Comédia
            _buildGenreSection(
                context, 'Comédia', 10, screenHeight, screenWidth),
            // Gênero Documentário
            _buildGenreSection(
                context, 'Documentário', 10, screenHeight, screenWidth),
            // Gênero Infantil
            _buildGenreSection(
                context, 'Infantil', 10, screenHeight, screenWidth),
            // Gênero Musical
            _buildGenreSection(
                context, 'Musical', 10, screenHeight, screenWidth),
            // Gênero Romance
            _buildGenreSection(
                context, 'Romance', 10, screenHeight, screenWidth),
            SizedBox(height: screenHeight * 0.05),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        selectedItemColor: const Color.fromRGBO(230, 31, 9, 1),
        unselectedItemColor: const Color.fromRGBO(230, 31, 9, 1),
        currentIndex:
            _currentIndex, // Define o índice atual da barra de navegação
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          // Adicione a lógica de navegação para cada item aqui
          if (index == 0) {
            // Já está na tela inicial, não é necessário navegação
          } else if (index == 1) {
            // Navegue para a tela de filmes
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CatalogScreen()),
            );
          } else if (index == 2) {
            // Navegue para a tela de perfil
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TelaPerfil()), // Substitua `TelaPerfil` pela sua tela de perfil
            );
          } else if (index == 3) {
            // Navegue para a tela de favoritos
          } else if (index == 4) {
            // Navegue para a tela de mapas
          } else if (index == 5) {
            // Lógica para sair
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Filmes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite), // Novo ícone 1
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map), // Novo ícone 2
            label: 'Mapas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Sair',
          ),
        ],
      ),
    );
  }

  Widget _buildGenreSection(BuildContext context, String genre, int itemCount,
      double screenHeight, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(screenWidth * 0.02, screenHeight * 0.02,
              screenWidth * 0.02, screenHeight * 0.01),
          child: Text(
            genre,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        CarouselSlider.builder(
          itemCount: itemCount,
          options: CarouselOptions(
            height: screenHeight * 0.35,
            viewportFraction: 0.7, // Mesma largura do primeiro slider
            enlargeCenterPage: true,
          ),
          itemBuilder: (BuildContext context, int index, int pageViewIndex) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaFilme(),
                  ),
                );
              },
              child: Container(
                height: screenHeight * 0.35,
                width: screenWidth * 0.6, // Mesma largura do primeiro slider
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), // Borda arredondada
                  border: Border.all(color: Colors.white), // Borda branca
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/poster_0${index % 3 + 1}.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/default_poster.png',
                          fit: BoxFit.cover);
                    },
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: screenHeight * 0.05),
      ],
    );
  }
}
