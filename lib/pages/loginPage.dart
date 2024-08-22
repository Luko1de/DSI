import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'homePage.dart';
import 'signUpPage.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Cor de fundo
      body: Container(
        padding: const EdgeInsets.only(top: 120, left: 40, right: 40),
        child: ListView(
          children: [
            // Logo MOVIEBOX
            SizedBox(
              width: 288, // Largura do ícone de pipoca
              height: 80,
              child: Image.asset(
                  'assets/Logo Extendida.png'), // Substitua pelo caminho da imagem do ícone de pipoca
            ),

            const SizedBox(height: 40),

            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon:
                    Icon(Icons.person, color: Colors.white), // Ícone do usuário
                labelText: "E-mail",
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
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[900], // Fundo do campo
              ),
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),

            const SizedBox(height: 20),

            // Campo de Senha
            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon:
                    Icon(Icons.lock, color: Colors.white), // Ícone de senha
                labelText: "Sua senha",
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
                suffixIcon: Icon(Icons.visibility,
                    color: Colors.white), // Ícone de visibilidade
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[900], // Fundo do campo
              ),
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),

            Container(
              height: 40,
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Lógica para recuperar senha (adicionar se necessário)
                },
                child: const Text(
                  "Esqueceu a senha?",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),

            // Botão de Entrar
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Cor de fundo do botão
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                onPressed: () {
                  // Navegar para a HomePage ao clicar no botão de login
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: const Text(
                  "Entrar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Texto "Ou entre com:"
            Text(
              "Ou entre com:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            // Ícones de redes sociais
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  iconSize: 50,
                  icon: Image.asset(
                      'assets/google.png'), // Caminho para a imagem do Google
                  onPressed: () {},
                ),
                IconButton(
                  iconSize: 50,
                  icon: Image.asset(
                      'assets/face.png'), // Caminho para a imagem do Facebook
                  onPressed: () {},
                ),
                IconButton(
                  iconSize: 50,
                  icon: Image.asset(
                      'assets/twitter.png'), // Caminho para a imagem do X
                  onPressed: () {},
                ),
                IconButton(
                  iconSize: 50,
                  icon: Image.asset(
                      'assets/icloud.png'), // Caminho para a imagem da Apple
                  onPressed: () {},
                ),
              ],
            ),

            const Spacer(),

            // Texto "Não tem uma conta? Cadastre-se"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Não tem uma conta?",
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    // Navegar para SignUpPage ao clicar no botão de cadastro
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text(
                    "Cadastre-se",
                    style: TextStyle(
                      color: Colors.red,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
