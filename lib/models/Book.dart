import 'package:cloud_firestore/cloud_firestore.dart';

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
    final highlightsMap = <Map<String, dynamic>>[];

  //   for (var highlight in highlights) {
  //     highlightsMap.add(highlight.toJson());
  //   }

    return {
      'highlight': '1',
    };
  }
}

class Highlight {
  final String text;
  final bool isFavorite;

  Highlight({required this.text, required this.isFavorite});
  factory Highlight.fromJson(Map<String, dynamic> data) {
    return Highlight(
      text: data['highlight'],
      isFavorite: data['isFavorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'highlight': text,
      'isFavorite': isFavorite,
    };
  }
}