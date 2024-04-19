import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('MovieBox'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Recomendados',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            CarouselSlider.builder(
              itemCount: 10,
              options: CarouselOptions(
                height: 250,
                viewportFraction: 0.55,
              ),
              itemBuilder:
                  (BuildContext context, int index, int pageViewIndex) {
                return Container(
                  height: 250,
                  width: 175,
                  child: Image.asset('assets/homem_aranha.jpeg'),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(220, 173, 208, 1.0),
        selectedItemColor: Color.fromRGBO(121, 85, 156, 1.0),
        unselectedItemColor: Color.fromRGBO(121, 85, 156, 1.0),
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
          } else if (index == 2) {
            // Navegue para a tela de perfil
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
            icon: Icon(Icons.exit_to_app),
            label: 'Sair',
          ),
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = ["Movie 1", "Movie 2", "Movie 3"];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Lista de ações para a barra de pesquisa
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Ícone de voltar para a barra de pesquisa
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Lógica para exibir resultados de pesquisa
    // Substitua pelo código necessário para exibir resultados com base na consulta
    return Center(
      child: Text('Resultados para: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Lógica para exibir sugestões de pesquisa
    final suggestions =
        searchTerms.where((term) => term.contains(query)).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}
