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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 32, 31, 31),
          title: Text('MovieBox'),
          // Define a cor branca para os ícones e o título
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          centerTitle: true,
          actions: []),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
              child: Text(
                'Acho que você pode gostar',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            CarouselSlider.builder(
              itemCount: 10,
              options: CarouselOptions(
                height: 250,
                viewportFraction: 0.2,
                // Ajuste para diminuir o tamanho do item e criar mais espaço
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
                    height: 250,
                    width: 175,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(16), // Borda arredondada
                      border: Border.all(color: Colors.white), // Borda branca
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/poster_0${index % 3 + 1}.png', // Certifique-se de que o nome do arquivo corresponde
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Se a imagem não for encontrada, exiba uma imagem padrão
                          return Image.asset('assets/default_poster.png',
                              fit: BoxFit.cover);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
              child: Text(
                'Drama',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            CarouselSlider.builder(
              itemCount: 10,
              options: CarouselOptions(
                height: 250,
                viewportFraction: 0.2,
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
                    height: 250,
                    width: 175,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(16), // Borda arredondada
                      border: Border.all(color: Colors.white), // Borda branca
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/poster_0${index % 3 + 1}.png', // Certifique-se de que o nome do arquivo corresponde
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Se a imagem não for encontrada, exiba uma imagem padrão
                          return Image.asset('assets/default_poster.png',
                              fit: BoxFit.cover);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
              child: Text(
                'Ficção Científica',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            CarouselSlider.builder(
              itemCount: 10,
              options: CarouselOptions(
                height: 250,
                viewportFraction: 0.2,
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
                    height: 250,
                    width: 175,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(16), // Borda arredondada
                      border: Border.all(color: Colors.white), // Borda branca
                    ), // Chave de fechamento adicionada aqui
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/poster_0${index % 3 + 1}.png', // Certifique-se de que o nome do arquivo corresponde
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Se a imagem não for encontrada, exiba uma imagem padrão
                          return Image.asset('assets/default_poster.png',
                              fit: BoxFit.cover);
                        }, // Borda branca
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
              child: Text(
                'Animação',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            CarouselSlider.builder(
              itemCount: 10,
              options: CarouselOptions(
                height: 250,
                viewportFraction: 0.2,
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
                    height: 250,
                    width: 175,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(16), // Borda arredondada
                      border: Border.all(color: Colors.white), // Borda branca
                    ), // Chave de fechamento adicionada aqui
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/poster_0${index % 3 + 1}.png', // Certifique-se de que o nome do arquivo corresponde
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Se a imagem não for encontrada, exiba uma imagem padrão
                          return Image.asset('assets/default_poster.png',
                              fit: BoxFit.cover);
                        }, // Borda branca
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
              child: Text(
                'Comédia',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            CarouselSlider.builder(
              itemCount: 10,
              options: CarouselOptions(
                height: 250,
                viewportFraction: 0.2,
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
                    height: 250,
                    width: 175,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(16), // Borda arredondada
                      border: Border.all(color: Colors.white), // Borda branca
                    ), // Chave de fechamento adicionada aqui
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/poster_0${index % 3 + 1}.png', // Certifique-se de que o nome do arquivo corresponde
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Se a imagem não for encontrada, exiba uma imagem padrão
                          return Image.asset('assets/default_poster.png',
                              fit: BoxFit.cover);
                        }, // Borda branca
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
              child: Text(
                'Documentário',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            CarouselSlider.builder(
              itemCount: 10,
              options: CarouselOptions(
                height: 250,
                viewportFraction: 0.2,
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
                    height: 250,
                    width: 175,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(16), // Borda arredondada
                      border: Border.all(color: Colors.white), // Borda branca
                    ), // Chave de fechamento adicionada aqui
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/poster_0${index % 3 + 1}.png', // Certifique-se de que o nome do arquivo corresponde
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Se a imagem não for encontrada, exiba uma imagem padrão
                          return Image.asset('assets/default_poster.png',
                              fit: BoxFit.cover);
                        }, // Borda branca
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
              child: Text(
                'Infantil',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            CarouselSlider.builder(
              itemCount: 10,
              options: CarouselOptions(
                height: 250,
                viewportFraction: 0.2,
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
                    height: 250,
                    width: 175,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(16), // Borda arredondada
                      border: Border.all(color: Colors.white), // Borda branca
                    ), // Chave de fechamento adicionada aqui
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/poster_0${index % 3 + 1}.png', // Certifique-se de que o nome do arquivo corresponde
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Se a imagem não for encontrada, exiba uma imagem padrão
                          return Image.asset('assets/default_poster.png',
                              fit: BoxFit.cover);
                        }, // Borda branca
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
              child: Text(
                'Musical',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            CarouselSlider.builder(
              itemCount: 10,
              options: CarouselOptions(
                height: 250,
                viewportFraction: 0.2,
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
                    height: 250,
                    width: 175,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(16), // Borda arredondada
                      border: Border.all(color: Colors.white), // Borda branca
                    ), // Chave de fechamento adicionada aqui
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/poster_0${index % 3 + 1}.png', // Certifique-se de que o nome do arquivo corresponde
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Se a imagem não for encontrada, exiba uma imagem padrão
                          return Image.asset('assets/default_poster.png',
                              fit: BoxFit.cover);
                        }, // Borda branca
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
              child: Text(
                'Romance',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            CarouselSlider.builder(
              itemCount: 10,
              options: CarouselOptions(
                height: 250,
                viewportFraction: 0.2,
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
                    height: 250,
                    width: 175,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(16), // Borda arredondada
                      border: Border.all(color: Colors.white), // Borda branca
                    ), // Chave de fechamento adicionada aqui
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/poster_0${index % 3 + 1}.png', // Certifique-se de que o nome do arquivo corresponde
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Se a imagem não for encontrada, exiba uma imagem padrão
                          return Image.asset('assets/default_poster.png',
                              fit: BoxFit.cover);
                        }, // Borda branca
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        selectedItemColor: Color.fromRGBO(230, 31, 9, 1),
        unselectedItemColor: Color.fromRGBO(230, 31, 9, 1),
        currentIndex:
            _currentIndex, // Define o índice atual da barra de navegação
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          // Adicione a lógica de navegação para cada item aqui
          if (index == 0) {
            // Navegue para a tela inicial
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
                      TelaPerfil()), // Substitua `ProfileScreen()` pela sua tela de perfil
            );
          } else if (index == 3) {
            // Navegue para a tela de sair
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
}

// 