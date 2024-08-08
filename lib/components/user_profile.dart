import 'package:flutter/material.dart';

class UserProfileImage extends StatelessWidget {
  final String imageAssetPath;

  const UserProfileImage({required this.imageAssetPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
      ),
      margin: EdgeInsets.symmetric(horizontal: 120, vertical: 13),
      height: 120,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: Image.asset(
          imageAssetPath,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
