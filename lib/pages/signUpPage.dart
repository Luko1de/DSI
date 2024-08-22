import 'package:flutter/material.dart';
import 'package:testes/components/genre_chips.dart';
import 'package:testes/pages/profileScreen.dart';
import 'package:testes/pages/loginPage.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthController = TextEditingController();

  bool _obscurePassword = true; // Estado para controlar a visibilidade da senha

  final List<String> genres = [
    "Ação", "Animação", "Aventura", "Comédia", "Drama",
    "Documentário", "Fantasia", "Ficção Científica", "Guerra",
    "Infantil", "Musical", "Romance", "Suspense", "Terror", "Thriller"
  ];

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _save() {
    // Navegar para a tela de perfil
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TelaPerfil()),
    );
  }

  void _cancel() {
    // Voltar para a tela de login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    birthController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration({
    required IconData icon,
    required String label,
    Widget? suffixIcon, // Adicione o parâmetro suffixIcon
  }) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: Colors.white),
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: const Color.fromARGB(255, 244, 67, 54)),
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: Colors.grey[900],
      suffixIcon: suffixIcon, // Use o suffixIcon aqui
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.add_photo_alternate,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                TextFormField(
                  controller: usernameController,
                  decoration: _buildInputDecoration(
                    icon: Icons.person,
                    label: 'Nome de usuário',
                  ),
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                
                const SizedBox(height: 10),
                
                TextFormField(
                  controller: emailController,
                  decoration: _buildInputDecoration(
                    icon: Icons.email,
                    label: 'E-mail',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                
                const SizedBox(height: 10),
                
                TextFormField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: _buildInputDecoration(
                    icon: Icons.lock,
                    label: 'Senha',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                          ? Icons.visibility_off // Ícone para ocultar a senha
                          : Icons.visibility, // Ícone para mostrar a senha
                        color: Colors.white,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                
                const SizedBox(height: 10),
                
                TextFormField(
                  controller: birthController,
                  decoration: _buildInputDecoration(
                    icon: Icons.calendar_today,
                    label: 'Data de Nascimento',
                  ),
                  keyboardType: TextInputType.datetime,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                
                const SizedBox(height: 20, width: 360),
                
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Escolha os seus gêneros favoritos",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                const SizedBox(height: 10),
                
                GenreChips(genres: genres), // Integrando GenreChips aqui
                
                const SizedBox(height: 20),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _save,
                      child: Text(
                        "Salvar",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.white),
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _cancel,
                      child: Text(
                        "Cancelar",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
