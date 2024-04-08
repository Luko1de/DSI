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
      child: DropdownButton<String>(
        items: <String>['Masculino', 'Feminino', 'Outro']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {
          // Você pode adicionar o código desejado aqui para lidar com a mudança de valor
        },
      ),
    );
  }
}
