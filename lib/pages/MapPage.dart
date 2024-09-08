import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'FavoritePage.dart';
import 'CatalogPage.dart';
import 'ProfilePage.dart';
import 'package:testes/components/lateral_nav_bar.dart'; // Importar o componente da barra lateral

class MapPage extends StatefulWidget {
  const MapPage({super.key});
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  int _currentIndex = 4; // Índice da barra lateral

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Adicione a lógica de navegação para cada item aqui
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CatalogPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FavoritePage()),
      );
    }
    // Nota: Não há navegação para MapPage pois já está na MapPage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LateralNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
      body: Center(
        child: Text('Map Page'),
      ),
    );
  }
}
