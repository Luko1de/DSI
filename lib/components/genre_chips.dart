import 'package:flutter/material.dart';

class GenreChips extends StatefulWidget {
  final List<String> genres;

  GenreChips({required this.genres});

  @override
  _GenreChipsState createState() => _GenreChipsState();
}

class _GenreChipsState extends State<GenreChips> {
  // Armazena os gêneros selecionados
  final Set<String> _selectedGenres = Set<String>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 288, // Define a largura máxima para os chips
      child: Wrap(
        spacing: 8.0, // Espaçamento horizontal entre os chips
        runSpacing: 4.0, // Espaçamento vertical entre as linhas de chips
        children: widget.genres.map((genre) {
          final isSelected = _selectedGenres.contains(genre);
          return FilterChip(
            label: Text(genre),
            backgroundColor: Colors.grey[800],
            selectedColor: Colors.red,
            selected: isSelected,
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  _selectedGenres.add(genre);
                } else {
                  _selectedGenres.remove(genre);
                }
              });
            },
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.white,
            ),
          );
        }).toList(),
      ),
    );
  }
}
