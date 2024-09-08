import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String obscurePassword;
  final String dateOfBirth;

  const UserInfoCard({super.key, 
    required this.title,
    required this.subtitle,
    required this.obscurePassword,
    required this.dateOfBirth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _infoCard(
          icon: "https://i.imgur.com/1tMFzp8.png",
          text: subtitle,
        ),
        _infoCard(
          icon: "https://i.imgur.com/1tMFzp8.png",
          text: obscurePassword,
        ),
        _infoCard(
          icon: "https://i.imgur.com/1tMFzp8.png",
          text: dateOfBirth,
        ),
      ],
    );
  }

  Widget _infoCard({required String icon, required String text}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFB4ADAC), width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 11),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 36),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            width: 20,
            height: 14,
            child: Image.network(
              icon,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFFFAFAFA),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
