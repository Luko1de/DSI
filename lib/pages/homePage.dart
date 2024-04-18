import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  color: Colors.amber,
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
        items: <BottomNavigationBarItem>[
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
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = ["Movie 1", "Movie 2", "Movie 3"];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Lista de ações para a barra de pesquisa.
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Ícone de voltar para a barra de pesquisa.
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Lógica para exibir resultados de pesquisa.
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Lógica para exibir sugestões de pesquisa.
    return ListView.builder(
      itemCount: searchTerms.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchTerms[index]),
          onTap: () {
            query = searchTerms[index];
            showResults(context);
          },
        );
      },
    );
  }
}
