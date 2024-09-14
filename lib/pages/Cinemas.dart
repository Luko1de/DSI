import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testes/pages/CatalogPage.dart';
import 'package:testes/pages/FavoritePage.dart';
import 'package:testes/pages/HomePage.dart';
import 'package:testes/pages/MapPage.dart';
import 'package:testes/pages/myMovies.dart';
import 'package:testes/pages/ProfilePage.dart';
import 'package:testes/components/lateral_nav_bar.dart';

import 'SignUpCinemas.dart';

class Cinemas extends StatefulWidget {
  const Cinemas({Key? key}) : super(key: key);

  @override
  State<Cinemas> createState() => _CinemasState();
}

class _CinemasState extends State<Cinemas> {
  int _currentIndex = 5; 
 // Índice da barra de navegação inferior
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
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
          MaterialPageRoute(builder: (context) =>  const ProfilePage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  const FavoritePage()),
        );
        break;
      case 4:
        Navigator.push(
          context, MaterialPageRoute(builder: (context) =>  MapPage()));
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const MeusFilmesPage()), // Adicione a nova tela
        );
        break;
      case 6:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Cinemas()),
        );
        break;
      default:
        break;
    }
  }

  void _deleteCinema(String id) async {
  try {
      await FirebaseFirestore.instance.collection('cinemas').doc(id).delete();
      print('Cinema deletado com sucesso!');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cinema deletado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } 
    catch (e) {
      print('Erro ao deletar cinema: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao deletar cinema!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  _updateCinema(String id, String nome, String cep, String logradouro, String numero, String cidade, String estado) {
    FirebaseFirestore.instance.collection('cinemas').doc(id).update({
      'nome': nome,
      'cep': cep,
      'logradouro': logradouro,
      'numero': numero,
      'cidade': cidade,
      'estado': estado,
    });
  }

  final List<String> _estados = ['AC', 'AL', 'AM','AP','BA','CE','DF','ES','GO','MA','MG','MS','MT','PA','PB','PE','PI','PR','RJ','RN','RO','RR','RS','SC','SE','SP','TO'];

  _showEditDialog(BuildContext context, QueryDocumentSnapshot cinema) {
    final TextEditingController _editCinemaController = TextEditingController(text: cinema['nome']);
    final TextEditingController _editCEPController = TextEditingController(text: cinema['cep']);
    final TextEditingController _editAdressController = TextEditingController(text: cinema['logradouro']);
    final TextEditingController _editNumberController = TextEditingController(text: cinema['numero']);
    final TextEditingController _editCityController = TextEditingController(text: cinema['cidade']);
    String? editEstadoSelecionado = cinema['estado'];

    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text('Editar Cinema'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _editCinemaController,
                decoration: const InputDecoration(labelText: 'Nome do Cinema'),
              ),
              TextField(
                controller: _editCEPController,
                decoration: const InputDecoration(labelText: 'CEP'),
              ),
              TextField(
                controller: _editAdressController,
                decoration: const InputDecoration(labelText: 'Logradouro'),
              ),
              TextField(
                controller: _editNumberController,
                decoration: const InputDecoration(labelText: 'Número'),
              ),
              TextField(
                controller: _editCityController,
                decoration: const InputDecoration(labelText: 'Cidade'),
              ),
              DropdownButtonFormField(
                items: _estados.map((String estado) {
                  return DropdownMenuItem(
                    value: estado,
                    child: Text(estado),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    editEstadoSelecionado = value;
                  });
                },
              ),
            ],
          ),
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              _updateCinema(cinema.id, _editCinemaController.text, _editCEPController.text, 
              _editAdressController.text,_editNumberController.text,_editCityController.text, editEstadoSelecionado!);
              Navigator.pop(context);
            },
            child: Text('Salvar'),
          ),

        ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 32, 31, 31),
        title: const Text('Cinemas'),
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        centerTitle: true,
        actions: const [],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu), // Ícone do menu
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Abre o Drawer ao clicar
              },
            );
          },
        ),
      ),
      drawer: LateralNavBar(
        // Adiciona o Drawer com o LateralNavBar
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('cinemas').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView(
                children: snapshot.data!.docs.map((cinema) {
                  return ListTile(
                    title: Text(cinema['nome'], style: TextStyle(color: Colors.white)),
                    subtitle: Text('${cinema['logradouro']}, ${cinema['cidade']} - ${cinema['estado']}',
                        style: TextStyle(color: Colors.white70)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteCinema(cinema.id), // Função para deletar
                    ),
                    onTap: () {
                      _showEditDialog(context, cinema); // Função para editar
                    },
                  );
                }).toList(),
              );
            },
          ),
          
          SizedBox(height: 20),
          
          Center(child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                  vertical: 15, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpCinemas()));
                  },
                    child: const Text(
                      "Adicionar Cinema",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                ),
                SizedBox(height: 12),
        ],
      ),
    );
  }
}