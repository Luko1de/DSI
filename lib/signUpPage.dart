import 'package:flutter/material.dart';
import 'package:testes/components/bluebutton.dart';
import 'package:testes/components/suspendedmenu.dart';
import 'package:testes/components/textfield.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child:Column(
          children: [
            const SizedBox(height: 50),
          
            const Icon(
              Icons.person,
              size: 100,
            ),

        SizedBox(height: 50),

        Text(
          "Bem vindo ao MoviesBox!",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color:Colors.grey[700],
        ),
        ),

        const SizedBox(height: 25),

        MyTextField(
          controller: usernameController,
          hintText: 'Nome Completo',
          obscureText: false,
        ),

        const SizedBox(height: 10),

        MyTextField(
          controller: usernameController,
          hintText: 'E-mail',
          obscureText: false,
        ),

        const SizedBox(height: 10),

        MyTextField(
          controller: passwordController, 
          hintText: 'Senha', 
          obscureText: true
          ),

        const SizedBox(height: 10),

        MyTextField(
          controller: passwordController, 
          hintText: 'Confirme a senha', 
          obscureText: true
          ),

        const SizedBox(height: 10),

        SuspendedMenu( 
          hintText: 'Gênero',
          ),

          const SizedBox(height: 10),

          BlueButton(onTap: () {},),

          ],
        ),
      ),
    );
  }
}


          