import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onSearch;

  const CustomSearchBar({required this.onSearch, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFB4ADAC),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 11),
            width: 20,
            height: 20,
            child: Image.network(
              "https://cdn-icons-png.flaticon.com/512/2866/2866321.png",
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Buscar filme favorito",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Color(0xFFFAFAFA),
                  fontSize: 10,
                ),
              ),
              style: TextStyle(
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
