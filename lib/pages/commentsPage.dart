import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllReviewsPage extends StatefulWidget {
  final String movieId;

  const AllReviewsPage({super.key, required this.movieId});

  @override
  _AllReviewsPageState createState() => _AllReviewsPageState();
}

class _AllReviewsPageState extends State<AllReviewsPage> {
  void _showEditReviewDialog(BuildContext context, String reviewId,
      Map<String, dynamic> currentReview) {
    final TextEditingController _ratingController =
        TextEditingController(text: currentReview['rating']?.toString() ?? '');
    final TextEditingController _commentController =
        TextEditingController(text: currentReview['comment'] ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            'Editar Comentário',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _ratingController,
                decoration: const InputDecoration(
                  labelText: 'Nota',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
              ),
              TextField(
                controller: _commentController,
                decoration: const InputDecoration(
                  labelText: 'Comentário',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('movies')
                    .doc(widget.movieId)
                    .collection('reviews')
                    .doc(reviewId)
                    .update({
                  'rating': _ratingController.text,
                  'comment': _commentController.text,
                });
                Navigator.of(context).pop();
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteReview(String reviewId) async {
    await FirebaseFirestore.instance
        .collection('movies')
        .doc(widget.movieId)
        .collection('reviews')
        .doc(reviewId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 20, 20),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: const Color.fromARGB(255, 24, 24, 24),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Avaliações do filme',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('movies')
                    .doc(widget.movieId)
                    .collection('reviews')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                          'Erro ao carregar comentários: ${snapshot.error}'),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text('Nenhum comentário disponível.'));
                  }

                  return ListView(
                    children: snapshot.data!.docs.map((doc) {
                      final review = doc.data() as Map<String, dynamic>;

                      return Dismissible(
                        key: Key(doc.id),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          _deleteReview(doc.id).then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Comentário excluído')),
                            );
                          });
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: ReviewTile(
                          reviewId: doc.id,
                          review: review,
                          movieId: widget.movieId,
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewTile extends StatefulWidget {
  final String reviewId;
  final Map<String, dynamic> review;
  final String movieId;

  const ReviewTile(
      {super.key,
      required this.reviewId,
      required this.review,
      required this.movieId});

  @override
  _ReviewTileState createState() => _ReviewTileState();
}

class _ReviewTileState extends State<ReviewTile> {
  bool _isEditing = false;
  late TextEditingController _ratingController;
  late TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _ratingController =
        TextEditingController(text: widget.review['rating']?.toString() ?? '');
    _commentController =
        TextEditingController(text: widget.review['comment'] ?? '');
  }

  @override
  void dispose() {
    _ratingController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _saveReview() async {
    await FirebaseFirestore.instance
        .collection('movies')
        .doc(widget.movieId)
        .collection('reviews')
        .doc(widget.reviewId)
        .update({
      'rating': _ratingController.text,
      'comment': _commentController.text,
    });
    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 22, 22, 22),
      child: ListTile(
        leading: const Icon(Icons.person, color: Colors.red, size: 40),
        title: _isEditing
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _ratingController,
                    decoration: const InputDecoration(
                      labelText: 'Nota',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      labelText: 'Comentário',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _saveReview,
                    child: const Text('Salvar'),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.review['email'] ?? 'Email não disponível',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Nota: ${widget.review['rating'] ?? 'N/A'}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.review['comment'] ?? 'Comentário não disponível',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
        onTap: () {
          setState(() {
            _isEditing = !_isEditing;
          });
        },
      ),
    );
  }
}
