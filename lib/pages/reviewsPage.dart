import 'package:flutter/material.dart';
import 'package:testes/components/bottom_nav_bar.dart';
import 'HomePage.dart';
import 'ProfilePage.dart';
import 'FavoritePage.dart';
import 'MapPage.dart';
import 'CatalogPage.dart';


class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  int _currentIndex = 0; 

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
        MaterialPageRoute(builder: (context) => CatalogPage()),
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
      backgroundColor: Colors.black, // Cor de fundo da tela
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Ícone branco
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
                fontSize: 24, // Maior tamanho de fonte para o título
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
                height: 8), // Espaçamento entre o título e o DropdownButton
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white), // Borda branca
                borderRadius: BorderRadius.circular(8), // Bordas arredondadas
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButton<String>(
                isExpanded:
                    true, // Para expandir o botão para a largura completa
                items: <String>['Opção 1', 'Opção 2', 'Opção 3']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16, // Menor tamanho de fonte para as opções
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // Ação quando um item é selecionado
                },
                hint: const Text(
                  'Escolha uma opção',
                  style: TextStyle(
                    fontSize: 16, // Menor tamanho de fonte para o hint
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                dropdownColor: Colors.black, // Cor de fundo do dropdown
                style: const TextStyle(
                  fontSize: 16, // Menor tamanho de fonte para o estilo
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ), // Cor do texto
                underline: const SizedBox(), // Remove a linha de sublinhado padrão
                iconEnabledColor: Colors.red, // Cor da seta do DropdownButton
              ),
            ),
            const SizedBox(
                height:
                    16), // Espaçamento entre o DropdownButton e o próximo texto
            const Row(
              children: [
                Icon(Icons.favorite, color: Colors.red),
                SizedBox(width: 8), // Distância entre o ícone e o texto
                Text(
                  'Favorito',
                  style: TextStyle(
                    fontSize: 16, // Menor tamanho de fonte para os textos
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8), // Espaçamento entre "Favorito" e "Assistido"
            const Row(
              children: [
                Icon(Icons.check_circle,
                    color: Colors.green), // Ícone ao lado de "Assistido"
                SizedBox(width: 8), // Distância entre o ícone e o texto
                Text(
                  'Assistido',
                  style: TextStyle(
                    fontSize: 16, // Menor tamanho de fonte para os textos
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
                height: 16), // Espaçamento entre "Assistido" e "Comentário"
            const Text(
              'Comentário',
              style: TextStyle(
                fontSize: 16, // Menor tamanho de fonte para os textos
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8), // Espaçamento entre "Comentário" e o TextField
            TextField(
              maxLines: 4, // Define o número de linhas para o campo de texto
              decoration: InputDecoration(
                hintText: 'Escreva seu comentário aqui',
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.black12, // Cor de fundo da caixa de texto
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.white), // Borda branca
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.white), // Borda branca
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.white), // Borda branca
                ),
              ),
              style: const TextStyle(color: Colors.white), // Cor do texto digitado
            ),
            const SizedBox(height: 16), // Espaçamento entre o TextField e o botão
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Ação quando o botão for pressionado
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Cor de fundo do botão
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20), // Bordas arredondadas
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 12), // Padding do botão
                ),
                child: const Text(
                  'Salvar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
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
