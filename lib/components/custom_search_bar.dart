import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onSearch;

  const CustomSearchBar({required this.onSearch, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFB4ADAC),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 11),
            width: 20,
            height: 20,
            child: Image.network(
              "https://cdn-icons-png.flaticon.com/512/2866/2866321.png",
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Buscar filme favorito",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Color(0xFFFAFAFA),
                  fontSize: 10,
                ),
              ),
              style: const TextStyle(
                color: Color(0xFFFAFAFA),
                fontSize: 10,
              ),
              onSubmitted: onSearch,
            ),
          ),
        ],
      ),
    );
  }
}
