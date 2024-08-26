import 'package:flutter/material.dart';

class UserProfileImage extends StatelessWidget {
  final String imageAssetPath;

  const UserProfileImage({
    Key? key,
    required this.imageAssetPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipOval(
        child: Image.asset(
          imageAssetPath,
          width: 120, // Definindo uma largura fixa para a imagem
          height:
              120, // Definindo uma altura fixa para a imagem (igual à largura para manter o círculo)
          fit: BoxFit
              .cover, // Cobre a área disponível, garantindo que a imagem preencha o círculo
        ),
      ),
    );
  }
}
