import 'package:flutter/material.dart';
import 'package:testes/components/puplebutton.dart';
import 'package:testes/components/suspendedmenu.dart';
import 'package:testes/components/textfield.dart';

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
        child:Column(
          children: [
            SizedBox(
              width: 360,
              height: 48,
              child: Image.asset('assets/logosignup.png'),
            ),

        const SizedBox(height: 25),

        MyTextField(
            decoration: InputDecoration(
            labelText: 'Nome Completo',
            labelStyle: TextStyle(
              color: Colors.black38,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
          controller: usernameController,
          hintText: 'Nome Completo',
          obscureText: false,
        ),

        const SizedBox(height: 10),

        MyTextField(
            decoration: InputDecoration(
            labelText: 'E-mail',
            labelStyle: TextStyle(
              color: Colors.black38,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
          controller: emailController,
          hintText: 'E-mail',
          obscureText: false,
        ),

        const SizedBox(height: 10),

        MyTextField(
          decoration: InputDecoration(
            labelText: 'Senha',
            labelStyle: TextStyle(
              color: Colors.black38,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
          controller: passwordController, 
          hintText: 'Senha', 
          obscureText: true
          ),

        const SizedBox(height: 10),

        MyTextField(
            decoration: InputDecoration(
            labelText: 'Data de Nascimento',
            labelStyle: TextStyle(
              color: Colors.black38,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
          controller: birthController, 
          hintText: '__/__/____', 
          obscureText: false
          ),

        const SizedBox(height: 10),

        SuspendedMenu( 
          hintText: 'Gênero',
          ),

          const SizedBox(height: 10),

          PurpleButton(onTap: () {},),

          ],
        ),
      ),
    );
  }
}


          
