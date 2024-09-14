import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:testes/components/lateral_nav_bar.dart';
import 'package:testes/components/section_title.dart';
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
  int currentIndex = 4; // Índice da barra de navegação inferior

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CatalogPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FavoritePage()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MapPage()),
        );
        break;
      default:
        break;
    }
  }

  final _formKey = GlobalKey<FormState>();

  //controladores para os campos de texto
  final TextEditingController _cinemaController = TextEditingController();
  final TextEditingController _adressController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  //Ajuste de máscara para o CEP
  final _cepMaskFormatter = MaskTextInputFormatter(
      mask: '#####-###', filter: {"#": RegExp(r'[0-9]')});

  //Lista dos Estados do Brasil
  final List<String> _estados = ['AC', 'AL', 'AM','AP','BA','CE','DF','ES','GO','MA','MG','MS','MT','PA','PB','PE','PI','PR','RJ','RN','RO','RR','RS','SC','SE','SP','TO'];
  String? estadoSelecionado;

  InputDecoration _buildInputDecoration({
    required String label,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.white,
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
  
  void _cancel() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MapPage()),
    );
  }

  void _cancelShowDialog(BuildContext context){
    showDialog(context: context, 
    builder: (BuildContext context){
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Cancelar Operação?'),
        content: const Text('Tem certeza que deseja cancelar a operação?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Não', style: TextStyle(color: Colors.black),),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _cancel();
            },
            child: const Text('Sim', style: TextStyle(color: Colors.red),),
          ),
        ],
      );
      });
  }

  //Create Cinema
  void _addCinema() {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore.instance.collection('cinemas').add({
        'name': _cinemaController.text,
        'adress': _adressController.text,
        'number': _numberController.text,
        'cep': _cepController.text,
        'city': _cityController.text,
        'state': estadoSelecionado,
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cinema cadastrado com sucesso!'),
          ),
        );
        _clearForms();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao cadastrar o cinema: $error'),
          ),
        );
      });
    }
  }
  _clearForms(){
    _cinemaController.clear();
    _adressController.clear();
    _numberController.clear();
    _cepController.clear();
    _cityController.clear();
  }

  //Build da tela


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Cinemas', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      drawer: LateralNavBar(
        currentIndex: currentIndex,
        onTap: _onItemTapped,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                SectionTitle(
                  title: 'Cadastro de Cinema',
                ),

                SizedBox(height: 32),
                //Nome
                TextFormField(
                  controller: _cinemaController,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  decoration: _buildInputDecoration(
                    label: 'Nome do Cinema',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome do cinema';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                //CEP
                TextFormField(
                  controller: _cepController,
                  decoration: _buildInputDecoration(
                    label: 'CEP',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [_cepMaskFormatter],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o CEP do cinema';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                //Logradouro
                TextFormField(
                  controller: _adressController,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  decoration: _buildInputDecoration(
                    label: 'Logradouro',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o logradouro do cinema';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                //Logradouro
                TextFormField(
                  controller: _numberController,
                  decoration: _buildInputDecoration(label: 'Número'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o número do logradouro do cinema';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                //Cidade
                TextFormField(
                  controller: _cityController,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  decoration: _buildInputDecoration(
                    label: 'Cidade',
                  ),
                  validator: (value) {
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
                        child: Text(
                          estado,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          onPressed: _addCinema,
                          child: const Text(
                            "Salvar",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white),
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          onPressed: () => _cancelShowDialog(context),
                          child: const Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
