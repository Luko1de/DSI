// lib/pages/tela_favoritos.dart
import 'package:flutter/material.dart';
//import '../components/custom_search_bar.dart';
import '../components/bottom_nav_bar.dart'; //
import 'custom_search_bar.dart'; //Importando o BottomNavBar

class TelaFavoritos extends StatelessWidget {
  const TelaFavoritos({super.key});

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
          color: Color(0xFFFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  color: Color(0xFF161616),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 38, bottom: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 12, left: 37),
                          child: Text(
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
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1, // Define o índice atual da barra de navegação
        onTap: (index) {
          // Lógica de navegação com base no índice do item selecionado
          if (index == 0) {
            // Navega para a tela inicial
            Navigator.pushNamed(context, '/inicial');
          } else if (index == 1) {
            // Já estamos na tela de favoritos, nenhuma ação necessária
          } else if (index == 2) {
            // Navega para a tela de perfil
            Navigator.pushNamed(context, '/perfil');
          } else if (index == 3) {
            // Executa a ação de sair
            Navigator.pushNamed(context, '/login');
          }
        },
      ),
    );
  }
}
