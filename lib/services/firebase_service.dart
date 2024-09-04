import 'package:cloud_firestore/cloud_firestore.dart';

// Função para adicionar um filme aos favoritos
Future<void> addToFavorites(
    String userId, Map<String, dynamic> movieData) async {
  final userFavoritesRef = FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('favorites');

  await userFavoritesRef.add(movieData);
}
