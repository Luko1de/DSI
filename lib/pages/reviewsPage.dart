import 'package:flutter/material.dart';
import 'homePage.dart'; // Importa a tela de início
import 'moviesScreen.dart'; // Substitua pelo caminho da sua tela de filmes
import 'profileScreen.dart'; // Substitua pelo caminho da sua tela de perfil

class TelaAvaliacoes extends StatefulWidget {
  @override
  _TelaAvaliacoesState createState() => _TelaAvaliacoesState();
}

class _TelaAvaliacoesState extends State<TelaAvaliacoes> {
  int _currentIndex = 0; // Índice atual da barra de navegação

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navegação para diferentes telas
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()), // Tela inicial
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TelaFilme()), // Tela de filmes
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TelaPerfil()), // Tela de perfil
        );
        break;
      case 3:
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Cor de fundo da tela
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Ícone branco
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
            Text(
              'Avaliar o filme',
              style: TextStyle(
                fontSize: 24, // Maior tamanho de fonte para o título
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
                height: 8), // Espaçamento entre o título e o DropdownButton
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white), // Borda branca
                borderRadius: BorderRadius.circular(8), // Bordas arredondadas
              ),
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButton<String>(
                isExpanded:
                    true, // Para expandir o botão para a largura completa
                items: <String>['Opção 1', 'Opção 2', 'Opção 3']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
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
                hint: Text(
                  'Escolha uma opção',
                  style: TextStyle(
                    fontSize: 16, // Menor tamanho de fonte para o hint
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                dropdownColor: Colors.black, // Cor de fundo do dropdown
                style: TextStyle(
                  fontSize: 16, // Menor tamanho de fonte para o estilo
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ), // Cor do texto
                underline: SizedBox(), // Remove a linha de sublinhado padrão
                iconEnabledColor: Colors.red, // Cor da seta do DropdownButton
              ),
            ),
            SizedBox(
                height:
                    16), // Espaçamento entre o DropdownButton e o próximo texto
            Row(
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
            SizedBox(height: 8), // Espaçamento entre "Favorito" e "Assistido"
            Row(
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
            SizedBox(
                height: 16), // Espaçamento entre "Assistido" e "Comentário"
            Text(
              'Comentário',
              style: TextStyle(
                fontSize: 16, // Menor tamanho de fonte para os textos
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8), // Espaçamento entre "Comentário" e o TextField
            TextField(
              maxLines: 4, // Define o número de linhas para o campo de texto
              decoration: InputDecoration(
                hintText: 'Escreva seu comentário aqui',
                hintStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.black12, // Cor de fundo da caixa de texto
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.white), // Borda branca
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.white), // Borda branca
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.white), // Borda branca
                ),
              ),
              style: TextStyle(color: Colors.white), // Cor do texto digitado
            ),
            SizedBox(height: 16), // Espaçamento entre o TextField e o botão
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
                  padding: EdgeInsets.symmetric(
                      horizontal: 32, vertical: 12), // Padding do botão
                ),
                child: Text(
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // Cor de fundo da barra de navegação
        selectedItemColor: Color.fromRGBO(230, 31, 9, 1),
        unselectedItemColor: Color.fromRGBO(230, 31, 9, 1),
        currentIndex:
            _currentIndex, // Define o índice atual da barra de navegação
        onTap: _onItemTapped,
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
