import 'package:flutter/material.dart';

class ChipMenu extends StatefulWidget {
  final List<String> options;
  final String labelText;

  const ChipMenu({Key? key, required this.options, required this.labelText}) : super(key: key);

  @override
  State<ChipMenu> createState() => _ChipMenuState();
}

class _ChipMenuState extends State<ChipMenu> {
  List<bool> isSelectedList = [];

  @override
  void initState() {
    super.initState();
    // Inicialize a lista de isSelected com valores falsos para cada opção
    isSelectedList = List<bool>.filled(widget.options.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            widget.labelText, // Usar o texto passado ao chamar o componente
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 18, 
            ),
          ),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8.0,
          children: List.generate(widget.options.length, (index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0), // borda arredondada
                border: Border.all(
                  color: Colors.grey, // cor da borda
                  width: 1.0, // largura da borda
                ),
              ),
              child: ChoiceChip(
                label: Text(widget.options[index]),
                selected: isSelectedList[index],
                selectedColor: Color.fromARGB(194, 107, 1, 156),
                onSelected: (isSelected) {
                  setState(() {
                    isSelectedList[index] = isSelected;
                  });
                },
              ),
            );
          }),
        ),
      ],
    );
  }
}
