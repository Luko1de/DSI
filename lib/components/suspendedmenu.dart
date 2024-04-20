import 'package:flutter/material.dart';

class SuspendedMenu extends StatelessWidget {
  final String? controller;
  final String hintText;

  const SuspendedMenu({
    Key? key, 
    required this.hintText,
    this.controller, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.grey[200], 
          borderRadius: BorderRadius.circular(10), 
        ),
        child: DropdownButton<String>(
          isExpanded: true, // Para fazer o DropdownButton se expandir horizontalmente
          underline: SizedBox(), 
          items: <String>['Masculino', 'Feminino', 'Não Binário', 'Outro']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 14, 
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: (String? value) {
            // logica do botao
          },
        ),
      ),
    );
  }
}
