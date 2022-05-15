import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:read_smart/models/Highlight.dart';

class Book {
  final String title;
  final String author;
  final String imageURL;
  final Timestamp lastAccessed;
  final List<Highlight> highlights;

  Book({
    required this.title,
    required this.author,
    required this.imageURL,
    required this.highlights,
    required this.lastAccessed,
  });

  factory Book.fromJson(Map<String, dynamic>? data) {
    final highlights = data!['highlights']
        .map((highlightData) => Highlight.fromJson(highlightData))
        .toList()
        .cast<Highlight>();

    return Book(
      title: data['title'],
      highlights: highlights,
      author: data['author'],
      imageURL: data['imageURL'],
      lastAccessed: data['lastAccessed'],
    );
  }

  toJson() {
    // TODO implement toJson return Map<String, dynamic>
    return {
      'highlight': '1',
    };
  }
}
