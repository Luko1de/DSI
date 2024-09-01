import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicial',
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
          icon: Icon(Icons.favorite),
          label: 'Favoritos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Cinemas',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: const Color(0xFFF5001E),
      unselectedItemColor: Colors.grey,
      onTap: onTap,
    );
  }
}
