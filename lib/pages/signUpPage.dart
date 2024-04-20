import 'package:flutter/material.dart';
import 'package:testes/components/chipmenu.dart';
import 'package:testes/components/purplebutton.dart';
import 'package:testes/components/suspendedmenu.dart';
import 'package:testes/components/textfield.dart';
import 'homePage.dart'; // Certifique-se de importar a classe HomePage

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final birthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: 360,
              height: 48,
              child: Image.asset('assets/Logo_MovieBox.webp'),
            ),
            const SizedBox(height: 25),
            const Text('Nome Completo', textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 18)),
            MyTextField(
              decoration: InputDecoration(
                labelText: 'Digite seu nome completo',
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              controller: usernameController,
              hintText: 'Nome Completo',
              obscureText: false,
            ),
            const SizedBox(height: 10),
            const Text('E-mail', textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 18)),
            MyTextField(
              decoration: InputDecoration(
                labelText: 'Digite seu e-mail',
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              controller: emailController,
              hintText: 'E-mail',
              obscureText: false,
            ),
            const SizedBox(height: 10),
            const Text('Senha', textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 18)),
            MyTextField(
              decoration: InputDecoration(
                labelText: 'Digite sua senha', 
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              controller: passwordController,
              hintText: 'Senha',
              obscureText: true,
            ),
            const SizedBox(height: 10),
            const Text('Data de Nascimento', textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 18)),
            MyTextField(
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              controller: birthController,
              hintText: '__/__/____',
              obscureText: false,
            ),
            const SizedBox(height: 10),
            const Text('Gênero', textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 18)),
            SuspendedMenu(
              hintText: 'Gênero',
            ),
            const SizedBox(height: 10),
            ChipMenu(
              labelText: 'Gêneros Favoritos',
              options: ['Ação', 'Aventura', 'Comédia', 'Drama', 'Sci-Fi', 'Documentário', 'Romance', 'Suspense', 'Terror', 'Fantasia', 'Musical', 'Thriller'],
            ),
            const SizedBox(height: 10),
            PurpleButton(
              onTap: () {
                // Navegar para a HomePage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
