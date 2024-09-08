import 'package:flutter/material.dart';

class LateralNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const LateralNavBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color(0xFFF5001E),
            ),
            child: const Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicial'),
            selected: currentIndex == 0,
            onTap: () {
              Navigator.pop(context);
              onTap(0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.movie),
            title: const Text('Filmes'),
            selected: currentIndex == 1,
            onTap: () {
              Navigator.pop(context);
              onTap(1);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            selected: currentIndex == 2,
            onTap: () {
              Navigator.pop(context);
              onTap(2);
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favoritos'),
            selected: currentIndex == 3,
            onTap: () {
              Navigator.pop(context);
              onTap(3);
            },
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: const Text('Cinemas'),
            selected: currentIndex == 4,
            onTap: () {
              Navigator.pop(context);
              onTap(4);
            },
          ),
          ListTile(
            leading: const Icon(Icons.video_library),
            title: const Text('Meus Filmes'),
            selected: currentIndex == 5,
            onTap: () {
              Navigator.pop(context);
              onTap(5); // Atualize o índice para a nova tela
            },
          ),
        ],
      ),
    );
  }
}
