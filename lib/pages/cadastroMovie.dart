import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../components/lateral_nav_bar.dart';
import 'HomePage.dart';
import 'CatalogPage.dart';
import 'ProfilePage.dart';
import 'FavoritePage.dart';
import 'MapPage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class TelaDeCadastroDeFilme extends StatefulWidget {
  final String? movieId;
  final Map<String, dynamic>? existingData;

  const TelaDeCadastroDeFilme({
    Key? key,
    this.movieId,
    this.existingData,
  }) : super(key: key);

  @override
  _TelaDeCadastroDeFilmeState createState() => _TelaDeCadastroDeFilmeState();
}

class _TelaDeCadastroDeFilmeState extends State<TelaDeCadastroDeFilme> {
  int _currentIndex = 0;
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _sinopseController = TextEditingController();
  final TextEditingController _elencoController = TextEditingController();
  final TextEditingController _duracaoController = TextEditingController();
  final TextEditingController _anoController = TextEditingController();
  final TextEditingController _notaController = TextEditingController();
  final List<String> _genres = [
    'Ação',
    'Comédia',
    'Drama',
    'Terror',
    'Romance',
    'Ficção Científica',
  ];
  List<String> _selectedGenres = [];
  File? _selectedImage;

  @override
  void initState() {
    super.initState();

    if (widget.existingData != null) {
      _nomeController.text = widget.existingData!['nome'] ?? '';
      _sinopseController.text = widget.existingData!['sinopse'] ?? '';
      _elencoController.text = widget.existingData!['elenco'] ?? '';
      _duracaoController.text =
          widget.existingData!['duracao']?.toString() ?? '';
      _anoController.text = widget.existingData!['ano']?.toString() ?? '';
      _notaController.text = widget.existingData!['nota']?.toString() ?? '';
      _selectedGenres = List<String>.from(widget.existingData?['genero'] ?? []);
      // Implementar lógica para carregar imagem existente, se necessário
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('movie_images/${DateTime.now().toIso8601String()}');
      final uploadTask = storageRef.putFile(image);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      // Salvar imagem localmente após o upload
      await _saveImageLocally(image, downloadUrl);

      return downloadUrl;
    } catch (e) {
      print('Erro ao fazer upload da imagem: $e');
      return null;
    }
  }

  Future<void> _saveImageLocally(File image, String downloadUrl) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/Users_data';
      final dir = Directory(path);

      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }

      final fileName = downloadUrl.split('/').last;
      final localFile = File('$path/$fileName');
      await image.copy(localFile.path);

      print('Imagem salva localmente em: $localFile');
    } catch (e) {
      print('Erro ao salvar imagem localmente: $e');
    }
  }

  Future<void> _cadastrarFilme() async {
    if (_nomeController.text.isEmpty ||
        _sinopseController.text.isEmpty ||
        _elencoController.text.isEmpty ||
        _duracaoController.text.isEmpty ||
        _anoController.text.isEmpty ||
        _notaController.text.isEmpty ||
        _selectedGenres.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos')),
      );
      return;
    }

    int? duracao = int.tryParse(_duracaoController.text);
    int? ano = int.tryParse(_anoController.text);
    double? nota = double.tryParse(_notaController.text);

    if (duracao == null || ano == null || nota == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Duração, ano e nota devem ser números')),
      );
      return;
    }

    String? imageUrl;
    if (_selectedImage != null) {
      imageUrl = await _uploadImage(_selectedImage!);
    }

    Map<String, dynamic> movieData = {
      'nome': _nomeController.text,
      'sinopse': _sinopseController.text,
      'elenco': _elencoController.text,
      'duracao': duracao,
      'ano': ano,
      'nota': nota,
      'imagem': imageUrl ?? widget.existingData?['imagem'] ?? '',
      'genero': _selectedGenres,
      'cadastradoPeloUsuario': true,
    };

    try {
      if (widget.movieId != null) {
        await FirebaseFirestore.instance
            .collection('filmes')
            .doc(widget.movieId)
            .update(movieData);
        print('Filme atualizado com sucesso.');
      } else {
        await FirebaseFirestore.instance.collection('filmes').add(movieData);
        print('Filme cadastrado com sucesso.');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Filme cadastrado com sucesso!')),
      );

      _nomeController.clear();
      _sinopseController.clear();
      _elencoController.clear();
      _duracaoController.clear();
      _anoController.clear();
      _notaController.clear();
      setState(() {
        _selectedImage = null;
        _selectedGenres = []; // Resetar gêneros selecionados
      });

      Navigator.pop(context);
    } catch (e) {
      print('Erro ao cadastrar o filme: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar o filme: $e')),
      );
    }
  }

  void _onItemTapped(int index) {
    Navigator.pop(context); // Fechar o Drawer após a navegação
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
          MaterialPageRoute(builder: (context) => const MapPage()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.movieId != null ? 'Editar Filme' : 'Cadastrar Filme'),
        backgroundColor: const Color(0xFF161616),
      ),
      drawer: LateralNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: _pickImage,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFFAFAFA),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    color: const Color(0x33000000),
                  ),
                  margin: const EdgeInsets.only(bottom: 20),
                  height: 156,
                  width: double.infinity,
                  child: _selectedImage == null
                      ? const Center(
                          child: Icon(
                            Icons.image,
                            color: Colors.white,
                            size: 50,
                          ),
                        )
                      : Image.file(_selectedImage!, fit: BoxFit.cover),
                ),
              ),
              _buildTextField("Nome do Filme", _nomeController),
              const SizedBox(height: 16),
              _buildTextField("Sinopse", _sinopseController, maxLines: 5),
              const SizedBox(height: 16),
              _buildTextField("Elenco", _elencoController),
              const SizedBox(height: 16),
              _buildTextField("Duração (em minutos)", _duracaoController),
              const SizedBox(height: 16),
              _buildTextField("Ano de Lançamento", _anoController),
              const SizedBox(height: 16),
              _buildTextField("Nota", _notaController),
              const SizedBox(height: 16),
              MultiSelectChip(
                _genres,
                selectedGenres: _selectedGenres,
                onSelectionChanged: (selectedList) {
                  setState(() {
                    _selectedGenres = selectedList;
                  });
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _cadastrarFilme,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEF233C),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.movieId != null ? 'Editar Filme' : 'Cadastrar Filme',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {int? maxLines}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      maxLines: maxLines ?? 1,
    );
  }
}

class MultiSelectChip extends StatefulWidget {
  final List<String> genreList;
  final List<String> selectedGenres;
  final Function(List<String>) onSelectionChanged;

  MultiSelectChip(this.genreList,
      {required this.selectedGenres, required this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  _buildChoiceList() {
    List<Widget> choices = [];

    widget.genreList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: widget.selectedGenres.contains(item),
          onSelected: (selected) {
            setState(() {
              if (selected) {
                widget.selectedGenres.add(item);
              } else {
                widget.selectedGenres.remove(item);
              }
              widget.onSelectionChanged(widget.selectedGenres);
            });
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
