import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:testes/components/bottom_nav_bar.dart';
import 'package:testes/pages/FavoritePage.dart';
import 'package:testes/pages/MapPage.dart';
import 'package:testes/pages/ProfilePage.dart';
import 'package:testes/pages/catalogPage.dart';
import 'package:testes/pages/homePage.dart';
import 'package:testes/pages/SignUpCinemas.dart';

class SignUpCinemas extends StatefulWidget {
  @override
  State<SignUpCinemas> createState() => _SignUpCinemasState();
}
class _SignUpCinemasState extends State<SignUpCinemas> {
  
  int _currentIndex = 4; // Índice da barra de navegação inferior

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CatalogPage()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfilePage()));
        break;
      case 3:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  FavoritePage()));
        break;
      case 4:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  MapPage()));
        break;
    }
  }

  
  final _formKey = GlobalKey<FormState>();

  //controladores para os campos de texto
  final TextEditingController _cinemaController = TextEditingController();
  final TextEditingController _adressController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  
  //Ajuste de máscara para o CEP
  final _cepMaskFormatter = MaskTextInputFormatter(mask: '#####-###', filter: { "#": RegExp(r'[0-9]') });

  //Lista dos Estados do Brasil
  final List<String> _estados = [
    'Acre', 'Alagoas', 'Amapá', 'Amazonas', 'Bahia', 'Ceará', 'Distrito Federal',
    'Espírito Santo', 'Goiás', 'Maranhão', 'Mato Grosso', 'Mato Grosso do Sul',
    'Minas Gerais', 'Pará', 'Paraíba', 'Paraná', 'Pernambuco', 'Piauí', 'Rio de Janeiro',
    'Rio Grande do Norte', 'Rio Grande do Sul', 'Rondônia', 'Roraima', 'Santa Catarina',
    'São Paulo', 'Sergipe', 'Tocantins'
  ];

  String? estadoSelecionado;

  InputDecoration _buildInputDecoration({
    required String label,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color.fromARGB(255, 244, 67, 54)),
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: Colors.grey[900],
      suffixIcon: suffixIcon,
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //Nome
              TextFormField(controller: _cinemaController,
              decoration: _buildInputDecoration(label: 'Nome do Cinema',),
              validator:  (value){
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o nome do cinema';
                }
                return null;
                },
              ),
              SizedBox(height: 20),
              //CEP
              TextFormField(controller: _cepController,
              decoration: _buildInputDecoration(label: 'CEP',),
              keyboardType: TextInputType.number,
              inputFormatters: [_cepMaskFormatter],
              validator:  (value){
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o CEP do cinema';
                }
                return null;
                },
              ),
              SizedBox(height: 20),
              //Logradouro
              TextFormField(controller: _adressController,
              decoration: _buildInputDecoration(label: 'Logradouro',),
              validator:  (value){
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o logradouro do cinema';
                }
                return null;
                },
              ),
              SizedBox(height: 20),
              //Cidade
              TextFormField(controller: _cityController,
              decoration: _buildInputDecoration(label: 'Cidade',),
              validator:  (value){
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira a cidade do cinema';
                }
                return null;
                },
              ),
              SizedBox(height: 20),
              //Estado
              Container(
                decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Estado'),
                items: _estados.map((String estado) {
                  return DropdownMenuItem<String>(
                    value: estado,
                    child: Text(estado, style: const TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.bold, ),),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    estadoSelecionado = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Por favor, selecione o estado';
                  }
                  return null;
                },
                hint: const Text(
                  'Selecione o Estado',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                dropdownColor: Colors.black,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                iconEnabledColor: Colors.red,
              ),
              ),

              SizedBox(height: 24),

              Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: (){
                        //crud
                      },
                      child: const Text(
                        "Salvar",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
              )
            ],
          )
          ),
        ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}